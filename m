Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B5606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KorxvIFP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3706C1121AE;
	Thu, 19 Nov 2026 08:51:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E35B1121AE
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:51:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E120760F8B;
 Thu, 19 Nov 2026 08:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7302F1F000C4;
 Thu, 19 Nov 2026 08:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078261;
 bh=6Bk8hCpsgZfl2HUhWcwGOm9G3pFHJ3P+zRUsS1eXKms=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KorxvIFPu8gO6ih4kjaVz80x2nSWMp8ZFCiuwHyqEWodzniwsKgHnOPpdS4W7OqXJ
 KE0vOk+IhlwnbB2AKTJ7fMZLJdrdndBPwnrd4x/FJdgzCyVihkVLavu1EEK8o+FX2c
 /GBB86a+87hfyNrrBnyjM3rAX9zm2vXX7ztwLpQsnpbLHGcPjRSRu6WVZqX/np2IRf
 e8TG3yXTvJARkhZ9hOHX+NFYqFSCfmJIfS6y8JxhsIoiiTot8cniDb9fQRWyFUJNsJ
 DGbEC64b2yK7/hzbvPcMUWMtsXrlPHRDELNaQaFLbaMrJ7GHf5PZ9oXGAoG0Oo+oqU
 xf/PC7Fl9Ebaw==
Message-ID: <sashiko-outbox-222728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 25/29] drm/msm/dp: mark the SST bridge disconnected
 when an MST-capable sink is present
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-25-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-25-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:51:01 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/msm/dp: msm_dp_bridge_detect() sets plugged and blocks boot
  MST enable
--

commit 743d14a69ac4db117bcd70993b4890a54c2ba917
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: mark the SST bridge disconnected when an MST-capable sink is pr=
esent

This commit returns connector_status_disconnected from msm_dp_bridge_detect=
()
when a multi-stream capable controller detects an MST-capable sink before
MST is activated.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 7f5247cbae035..6f1f9dd3660d0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1063,6 +1063,11 @@ enum drm_connector_status msm_dp_bridge_detect(str=
uct drm_bridge *bridge,
>  			status =3D connector_status_disconnected;
>  	}
> =20
> +	/* Mark SST connector as disconnected in DP boot-up case */
> +	if (msm_dp_ctrl_get_stream_cnt(priv->ctrl) > 1 &&
> +	    drm_dp_read_mst_cap(priv->aux, dpcd) =3D=3D DRM_DP_MST)
> +		status =3D connector_status_disconnected;

[Severity: High]
Does leaving priv->plugged set to true here prevent
msm_dp_hpd_plug_handle() from enabling MST when an MST-capable sink is
connected at boot?

Earlier in msm_dp_bridge_detect(), priv->plugged is set to true before this
check overrides status to connector_status_disconnected while dp->mst_active
is still false.  When msm_dp_hpd_plug_handle() later runs, it returns early
without calling msm_dp_display_process_hpd_high() or
msm_dp_display_mst_enable():

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_hpd_plug_handle() {
    ...
	if (dp->plugged)
		return 0;
    ...
	ret =3D msm_dp_display_process_hpd_high(dp);
    ...
}

As a result, the SST connector reports disconnected while MST topology
discovery is never started, leaving both SST and MST display output
non-functional.  In addition, because dp->mst_active stays false while
priv->plugged is true, each later msm_dp_bridge_detect() call takes a new
runtime PM reference via pm_runtime_resume_and_get() and skips
pm_runtime_put_sync() under if (!priv->plugged), leaking a runtime PM
reference per detect call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D25
