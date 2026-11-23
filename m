Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B21606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.a=rsa-sha256 header.s=s1-ionos header.b=s1XxH9Gc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D0210EC53;
	Mon, 23 Nov 2026 11:09:35 +0000 (UTC)
X-Greylist: delayed 349 seconds by postgrey-1.36 at gabe;
 Mon, 23 Nov 2026 11:09:28 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C1310EC53
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:09:28 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795432167;
 mf=PGplbnMuZ2xhdGhlQG9sZHNjaG9vbHNvbHV0aW9ucy5iaXo+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 d=oldschoolsolutions.biz;
 s=s1-ionos:rsa-sha256:x3OC3AWR5OIaKmYu0JQ/tfJMxGjo
 qJBOe1uIQw+C3u4jz72qjo/UbqqbliAI0aVOgnbI+kF7gC8tCW5fQgy3hFfbp8f+m0aajzAu6Ib
 7bTUSACQEM6bWsj7FOy7nYUMWHSANjae5ZvNhg32ghBCPRZoGs1EMxenLFSdkj3LyDvOEM39IxV
 jXUPL2ZKl51dD4MgFiycAqAiX/zW28+OEL5J7Rn3jrbyVci2SnEc3PgRd8gLecvtLQukHF02yet
 GNCZ2Nzf5ltn0qRK+D6Gd1JkG27Ang3jqZj+DkddVYO7qI/YnC8Wyiu7kkOhEHz7vqbFOsoOFvz
 y0UxEEooyIMhLQ==;
Message-Instance: m=1; h=sha256: eFkQtz5JvGNWTr2NCL/WBIwN7kDdkVNzLU0HsAdmRVI=:
 Hk6rTRz6/QNazFIRGMhV7PaLo3a5ytEMm3RVpwQoqok=, sha512:
 Ex+bS7ojEAsy+WBm0A30CXA5qTvS36Sg/q5UzuP4DJgFVfnPCitLwajq19Edte7LJWgd2DkEZDRw7CLA9LFf6A==:
 qBxQPoOSL+IvUaNDS7i5l2FOqPVzP8d2UqJF7c/VI6FUMZfRKmh9yipoiiY5VEuBczH6usGgCieXByTKjz45YQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oldschoolsolutions.biz; s=s1-ionos; t=1795432167; x=1796036967;
 i=jens.glathe@oldschoolsolutions.biz;
 bh=Hk6rTRz6/QNazFIRGMhV7PaLo3a5ytEMm3RVpwQoqok=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=s1XxH9GchipYPnsILEmOAw9QxuouHMIKPYruI5ioxgdXnuDPsWqyjjSmLU3puw7S
 kWWvEF45jkdweZAta4s4PG0x9ETsaY1QAoWRmyAvU8l18RFLrD1xvSJf+1YCPoS/4
 TflgnhoN2tlTnzUbekdH66BREXkfyuZy9qbleLpoluDnYC4nqwzu/nOCPaA3bNcSs
 TOCoOqaHzauY7pc5Zpj2eY4h462VP7Rm8DfY2smgWhvf0nawuHDt9AVUWXAcJvj3k
 3IGESFtHB5eFbrOzkPjOfBkkilf19RR0pM9vWHJ5EZVpctDkWNuv8GzTH7BPzhfVR
 UqayvAPhHxOeebnF0A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MF3Y8-1xkr5l34oa-00CMz5; Mon, 23
 Nov 2026 12:02:57 +0100
Message-ID: <6298b3d0-db8e-4342-9abd-4c104bac8e27@oldschoolsolutions.biz>
Date: Mon, 23 Nov 2026 12:02:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/msm/dp: fix DisplayPort hotplug, link training,
 and multi-lane PHY setup
To: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Dale Whinham <daleyo@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261121214105.32596-1-gianfranco.mariotti94@gmail.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <20261121214105.32596-1-gianfranco.mariotti94@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9NpQ9UOLW0+S3urrZosyOPkiAsn7T16Tq8t28v3DxpnaZnKc1AY
 VEqpfwb+U/gubW7i65oR9kA2JYLGCOyM8MptoAB0gj9V/jPf6jguLNrIZMjP3WNPXgrgDtF
 i8RiS+2mNPam+z4Oxcdt/+cYqo7UIaYplPTMFJ2riMQf0dIJrUJsFE9MvX4kQtYv0L6xYpT
 b0OuDCzQ64OKFCQhNR0CA==
UI-OutboundReport: notjunk:1;M01:P0:s3CFeXMqcjI=;4D+FejlrAX+rqgHMAj3oKkHJCnK
 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
 WorXzXp+qQKS1Gf0kPkYfrxzE+jglBya0=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/21/26 22:40, Gianfranco Mariotti wrote:

> On platforms with a native DisplayPort connector using direct HPD
> interrupts, DisplayPort initializes on cold boot, but physical cable
> unplug and re-plug cycles leave the display blank even though link
> training and stream enable callbacks report success.
>
> This series fixes the underlying PHY lane setup, DPCD link-rate caching,
> SST training-pattern handover, link maintenance BPC restoration, and
> HPD / runtime-PM state tracking issues:

Hi Gianfranco,

thanks for this series. I backported it to 7.3.y [1] and tested it on a
Lenovo IdeaCentre Mini 01Q8X10 (X1P42100) with 50 rounds of DPMS
off/on, first HDMI only (Parade PS186 branch), then HDMI plus a second
display behind a Lenovo USB-C dock (40B0, DP alt mode pin D, 2 lanes
through two LTTPRs).

Before, external displays behind the HDMI bridge regularly failed to
retrain after DPMS wake on 7.2+. With the series, every wake trained
once at HBR2, CR/EQ passed on both links, and video came up every
round on both outputs. No "already disabled" or PHY power_count issues.

Notes on the backport:
- 2/7 is covered in 7.3 by the link_info memset from Anthony Ruhier's
 =C2=A0 172c1648222e ("drm/msm/dp: recompute the link capabilities on ever=
y
 =C2=A0 sink read"), so I dropped it.
- 5/7: 7.3 already routes native IRQ_HPD via 216110888698 ("drm/msm/dp:
 =C2=A0 Handle IRQ HPD as a sink request"), so I only carried over the
 =C2=A0 pm_runtime_put() change there.
- 7/7: 7.3 lacks 1bda647ce61b ("drm/msm/dp: move link-level teardown
 =C2=A0 from display_disable to display_unprepare"), so the teardown still=
=20
lives in
 =C2=A0 msm_dp_display_disable(); I applied the dp->plugged gating there
 =C2=A0 instead of in unprepare.

One observation: on DPMS off, the PS186 still raises an HPD IRQ about
100 ms after the link is disabled, which sends a hotplug uevent per
connector, with get_modes reporting "No sink connected". It's harmless
here, but some debouncing may be worth adding on top later.

For the series, as tested on X1P42100:

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz> #=20
x1p42100-lenovo-ideacentre-mini

[1]=20
https://github.com/jglathe/linux_ms_dev_kit/tree/jg/ubuntu-qcom-x1e-7.3.y

Best regards,
Jens

