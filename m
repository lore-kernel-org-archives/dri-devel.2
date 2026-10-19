Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685D7CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C4410E36D;
	Mon, 19 Oct 2026 11:39:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E028610E64D
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:39:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 11BEF600CB;
 Mon, 19 Oct 2026 11:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572A11F000C4;
 Mon, 19 Oct 2026 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792409955;
 bh=lplIOhIV5V0C/jHRmjr3FKaB3R0Z/dkdoI6azjkHDJ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lkjTsFaOrrOmdyrjXe8F4qDQ1CntmfPDejDjhvnfHqS18wXVODe/Oj93eXQATUEv9
 82vYL6/F+oKV+U/3q0H/BHXge9sgO70CYyKxPuvoLQiHs3uA/1U2YQZ1j0OE64of13
 mRgyq1NJOTs9a3FduooW7irxbYFpbLAn03M2B6k2r1A81BzhNsw2oTQ79wf+SV1K4R
 My/VT3HzViF/zQaLzhMZTYcrQWEB2jpU1iqM11H3j2Pjpb8BdyYd7kQYS/eslNfIdB
 VNWbaFQKTuJ2E6KdiyZsN5jztSWTNyErEGTyvaOKp0YRBlDD71UYLbGcvyp9U66I9J
 CMjG7yrUcezIw==
Message-ID: <sashiko-outbox-177045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] regulator: add Qualcomm LCDB driver
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 mfd@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, lee@kernel.org
In-Reply-To: <20261019-sm8150-display-card-v2-4-86c05068efc5@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-4-86c05068efc5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 11:39:14 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] regulator: qcom-lcdb: off-by-one and window reset in qcom_lcdb_h=
andle_sc()
--

commit 5b5d0fa4182dea42061084cb3ab6d86b894783ff
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

regulator: add Qualcomm LCDB driver

This commit adds a regulator driver for the Qualcomm LCDB (LCD bias) block
found on PMICs such as PMI632, PM6150L, and PM8150L. It manages the shared
module enable, boost headroom tracking, voltage ramp-up, and short-circuit
recovery for the LDO and NCP bias rails.

> diff --git a/drivers/regulator/qcom-lcdb-regulator.c b/drivers/regulator/=
qcom-lcdb-regulator.c
> new file mode 100644
> index 0000000000000..bb2d4ee23ad5c
> --- /dev/null
> +++ b/drivers/regulator/qcom-lcdb-regulator.c
> @@ -0,0 +1,494 @@

[ ... ]

> +static bool qcom_lcdb_handle_sc(struct qcom_lcdb *lcdb)
> +{
> +	guard(mutex)(&lcdb->lock);
> +
> +	if (!lcdb->enabled_mask || lcdb->sc_disabled)
> +		return false;
> +
> +	qcom_lcdb_module_disable(lcdb);
> +
> +	if (ktime_us_delta(ktime_get(), lcdb->sc_time) > LCDB_SC_RESET_CNT_DLY_=
US) {
> +		lcdb->sc_count =3D 0;
> +	} else if (lcdb->sc_count > LCDB_SC_CNT_MAX) {
> +		dev_err(lcdb->dev, "persistent short circuit, keeping the outputs off\=
n");
> +		lcdb->sc_disabled =3D true;
> +		return true;
> +	}
> +
> +	lcdb->sc_count++;
> +	lcdb->sc_time =3D ktime_get();

[Severity: Medium]
Does qcom_lcdb_handle_sc() have an off-by-one in the retry count and reset
the 1-second fault window on every short-circuit event?

The commit message notes that on a short circuit the module is restarted up
to ten times within a second. However, in qcom_lcdb_handle_sc(),
lcdb->sc_count > LCDB_SC_CNT_MAX is evaluated before lcdb->sc_count++,
allowing 11 restarts (for lcdb->sc_count values 0 through 10) before
disabling the outputs on the 12th fault.

In addition, lcdb->sc_time =3D ktime_get() is updated on every fault rather
than only when starting a new counting window. Because ktime_us_delta()
measures the time since the immediately preceding fault instead of the first
fault in the window, intermittent faults spaced less than 1 second apart
(for example, every 0.8 seconds) will never reset lcdb->sc_count and will
permanently disable the rails across multiple seconds.

> +
> +	if (qcom_lcdb_module_enable(lcdb)) {
> +		dev_err(lcdb->dev, "failed to recover from a short circuit\n");
> +		lcdb->sc_disabled =3D true;
> +		return true;
> +	}
> +
> +	return false;
> +}

[ ... ]

=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=F0=9F=A4=96 ThisDimensions (v1.2 =C2=B7 gpt-5.4) =C2=B7 2026-10-19 04:01 U=
TC =C2=B7 [=F0=9F=93=9A](https://github.com/masoncl/review-prompts)
  =F0=9F=93=A7 dmitry.baryshkov@oss.qualcomm.com =C2=B7 =F0=9F=92=AC ~420 w=
ords =C2=B7 =F0=9F=AA=99 ~15k tokens =C2=B7 =F0=9F=92=B0 ~$0.05 ([=F0=9F=93=
=8A](https://platform.openai.com/docs/pricing))
=E2=94=80=E2=94=80=E2=94=80=E2=94=80

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-sm8150-dis=
play-card-v2-0-86c05068efc5@oss.qualcomm.com?part=3D4
