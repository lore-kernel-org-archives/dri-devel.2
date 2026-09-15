Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5FCC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A392310E0F7;
	Tue, 15 Sep 2026 19:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMy2FBGg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AzopuWQB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940B310E0F7
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 19:28:20 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FItlXH4076088
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 19:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ojaDUPtHd9cNx4slbCoFV2pZnXL+A0EcEEXwY6+H/Z4=; b=pMy2FBGg0KSMyQ9c
 PHxpTC84ELI/yk0d6Vbgiwt6drPpMKNfm/lMfhoOiVcIj1OhWUHh6xIfcjDtFswZ
 4yGgY7oWZVPyu4lIICecP2XbL1td1XZkk6VHIAp66Kwrj3Qw5IC52tF5PXTxOGjx
 DZm1QIVkDn9owl4UnxDHvaAFwcmhMKCEmlfAX/6aqMIYdbq6pkeTnBMg4ryjSd/7
 cvXrGDgsEqQTktkkhc8of97xYFVK1V0xlrLa0OUdCTmX961+cdrmfdY/9hCUBLDc
 nMjQyp2a8tMboW0zp/tfxMYHMiXQubsrMwn+Voq2ICDX1U9PoqnNfV/c4hWNNqSv
 Tbi/Aw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqbmng5j3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 19:28:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so6406281a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789500499; x=1790105299;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ojaDUPtHd9cNx4slbCoFV2pZnXL+A0EcEEXwY6+H/Z4=;
 b=AzopuWQBZiGlZh6gCfbFnjRlKq3o0SR+mgdhA4r5f65qeHPos3zawBgGnYiUMcE2d8
 bWA0i7yJsxgRry6EiHr4vnbuOwgSx7VGMoAudVc3/Y9l64QSDtqU92I21aSyudMxKkOl
 ZJby736WluA6IyFWwOlR+qXdv1IdiWOz92lw0Ls3sYhGumwxP4pgiEyOqEL/LnPlyXPo
 Bp2QzouO78EIXMJFPikTY1emQLqEslbLpWZrpN6Gud+Wc5NbFuKaTbMPcTFRM4qfZUb6
 yznh0vVKqAOq7wCf0ThzlFX628zA1bjlUvjc6XaYpf/EgYgDszXcBAmxJif1sM5Ac7Ho
 w3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500499; x=1790105299;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ojaDUPtHd9cNx4slbCoFV2pZnXL+A0EcEEXwY6+H/Z4=;
 b=AbBdey63i4pZbiS+iTla+16aH58cd/7kDpvFA1KBmWwwRXYBWWc3mjRXy9qp7IARuI
 KQ6Ri3JE1SSswrnJrGmgaj/2zDVjPwi0TqXhtVeUMGlMgUfXFXYGHU1Bhwg7BBW+oNW+
 qLAyYv4kiyxcXf8YEWTZr/BK+4zbcFs3f84jUfbdQzFpbuTvPbfKkFxKYOoBN/d5MuL3
 vpWcsib1cteP5W24mVAmFNXpMzswyKkgf9cDhmmsd/w1NVV8xRoxKRKNTJMdebebg7VF
 MGreiIQFMbR4Szo/mn6yrGXpeF22NTdQmWMu/az8b6oi3lyZsSFLRnI5Z5QmCvTC7dIy
 aRxw==
X-Gm-Message-State: AFuF++kknX7PHelXRRvEIB3603PRHl3rbrCFHHs7+gtt3RaStM/Yz7sn
 6NVmRFRdYoe6w41MWJN1ysvINq2UyeRI6BrwHTUhUSe5Ei3MH8TEAfKBaf5EZM8ll+hfycWDzud
 5fEO3xaKVlb2C4AcsdopWog7Sj2x4YonmucGOWFfXKuwHVF5hR10dWM4PIah5kmW3C2NMHOc=
X-Gm-Gg: AYBFou3+oOZOa/TM5yKxMzkupe5zbTSv4c6Ge24Q0esWzuTVFAUTahf8Cv3vz8QuMUQ
 azzT/tXQypoydsQHqqNTFcBqtdmA2nl8V1qhrFNbdFYM1NqLkYY8jy3rh6kJAtOTpamw/+DQWyj
 hOKIS8bSbbjqXrWNHeSQRQX1OK9qilTLTPajzGUXvjQ+2dSjDTBKesS/olssTUiPfuMLMHZjWQX
 JYTnos0jtkzzFy1cgK/N1i+1Hy4WptDXuwRr3C1xPXvdlHqxM9y1HVKEnZlxdFMMta4DF4jikwt
 xkzUKDTtigZUZbAKzjVWqO+OHs5YTDbfuEP3BXHIKfJAZlgcvLnMtDlV752TZxsCM6LWOJu0wOk
 D4jPtngi/y+MakQFATyFasD745w==
X-Received: by 2002:a05:6a20:b40b:b0:3d3:aec2:4dc9 with SMTP id
 adf61e73a8af0-3db405976a6mr19102810637.21.1789500499064; 
 Tue, 15 Sep 2026 12:28:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:b40b:b0:3d3:aec2:4dc9 with SMTP id
 adf61e73a8af0-3db405976a6mr19102770637.21.1789500498610; 
 Tue, 15 Sep 2026 12:28:18 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d76834sm782199c88.14.2026.09.15.12.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:28:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 00:58:12 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v16 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <aqmcTK4vyKX/J7dK@hu-mdsor-hyd.qualcomm.com>
References: <20260916-lt9611c-v7-v16-0-c65042fcd245@oss.qualcomm.com>
 <20260916-lt9611c-v7-v16-2-c65042fcd245@oss.qualcomm.com>
 <20260915190337.607831F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915190337.607831F000FF@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=POyaavqC c=1 sm=1 tr=0 ts=6aa99c53 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=JW9JmUXexGuFTMD2F-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MyBTYWx0ZWRfX86wXFgghsPTj
 WLLTHrUjvqWIOJvGyrmV6hpJnAzllyTgGrBOgjX87WyFGPyroUW7CrBD3r0FzYNKNd5UBiFktOM
 p0K4FOiV5rg0lOelLe1fnuLhtL6shqiBy1ZWmXGb/u4wc31+jWeB5B2jSGnx4ppEO64BBw1pdGT
 zr1X0sStXK6+6MF0Dj6HmsQNpsuaMiUMkZPfjj7M5IINoU5jQyyMBuanYzvTESHtP0/Vi+q7fu3
 I6jic92PnLnbOsdLEjRte3lYuvmMjMxaqMwcnRSwMbVJ+lMHLaWWutBDSk81AjsktuLg8h+llWI
 143QH3Brv82v8juJl37mS6XraR7wVZkzxgKxQcUHqAitRR1Mj8syrRHrt72QiFEyW2XQNksSgjI
 196P7NVzTj/yYTpFDP1BrInEX+gXTg/VSeNUf/tLm7+1a3Q3tNDYfu9YyUfQzHukLZecsZHBAt6
 E0ESDV/Yq4VytmplCZg==
X-Proofpoint-GUID: 76aOu2rFCRpLNloxckz9ZWRKtV9GH0Mb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MyBTYWx0ZWRfX/Fi/9VfW/jep
 683uN+f13OLYgYkExaFbV/mt1YZDpNaPgEbZVCo/pb/6IabvUG0YBVkTRrvqtXfsVDOgUD04l91
 kU5VLYHtT4ikr8GSwslNGwWzLiWnRD4=
X-Proofpoint-ORIG-GUID: 76aOu2rFCRpLNloxckz9ZWRKtV9GH0Mb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150283
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Sep 15, 2026 at 07:03:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] drm/bridge: premature bridge registration causes UAF on probe failure
> - [High] drm/bridge: missing HDMI formats and max_bpc initialization causes display failure
> --
> 
> commit 845a14001f40c5c49616eeff3efbd5f04313cc72
> Author: Sunyun Yang <syyang@lontium.com>
> 
> drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
> 
> This commit introduces the DRM bridge driver for the Lontium
> LT9611C(EX/UXD) MIPI DSI to HDMI converter chips. It supports single or
> dual MIPI DSI and I2S signals to HDMI output.
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > new file mode 100644
> > index 0000000000000..54ae535339f74
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> [ ... ]
> > @@ -1160,20 +1160,20 @@
> [ ... ]
> > +	lt9611c->bridge.of_node = client->dev.of_node;
> > +	lt9611c->bridge.ops = DRM_BRIDGE_OP_DETECT |
> > +			DRM_BRIDGE_OP_EDID |
> > +			DRM_BRIDGE_OP_HPD |
> > +			DRM_BRIDGE_OP_HDMI |
> > +			DRM_BRIDGE_OP_HDMI_AUDIO;
> 
> [Severity: High]
> Will setting the DRM_BRIDGE_OP_HDMI flag here cause connector initialization
> to fail?
> 
> It looks like the bridge.supported_formats and bridge.max_bpc fields are not
> initialized before this is set. When drm_bridge_connector_init() calls the
> core helper drm_connector_hdmi_init(), it strictly validates these parameters.
> Because they are implicitly zero-initialized, drm_connector_hdmi_init() will
> return -EINVAL, which would deterministically fail the connector creation and
> render the display driver non-functional.
> 
> Should these HDMI capabilities be explicitly set before enabling the HDMI ops
> flag?
drm_bridge_connector_init() uses safe defaults when bridge->supported_formats and bridge->max_bpc are zero — it defaults to
BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) and 8bpc respectively (see drm_bridge_connector.c lines 826-827). The bridge fields are
only used as overrides when non-zero (lines 911-914). No explicit initialization is needed and connector creation will
succeed.
> 
> > +	lt9611c->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
> > +
> > +	lt9611c->bridge.vendor = "Lontium";
> > +	lt9611c->bridge.product = "LT9611C";
> > +
> > +	lt9611c->bridge.hdmi_audio_dev = dev;
> > +	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels = 8;
> > +	lt9611c->bridge.hdmi_audio_dai_port = 2;
> > +
> > +	drm_bridge_add(&lt9611c->bridge);
> > +
> > +	/* Attach primary DSI */
> > +	dsi = lt9611c_attach_dsi(lt9611c, dsi0_node);
> > +	if (IS_ERR(dsi)) {
> > +		ret = PTR_ERR(dsi);
> > +		goto err_remove_bridge;
> > +	}
> 
> [Severity: High]
> Can this sequence lead to a use-after-free if the DSI attachment fails?
> 
> Because drm_bridge_add() makes the bridge globally visible on the bridge_list,
> another KMS driver could concurrently discover and attach to it during this
> window. If the subsequent lt9611c_attach_dsi() call fails (for example,
> returning -EPROBE_DEFER), the driver calls drm_bridge_remove() and returns an
> error, which triggers devres to free the memory backing the bridge.
> 
> Could the concurrent KMS driver be left holding a dangling pointer to
> devres-freed memory? Should drm_bridge_add() be deferred until all resources
> are successfully acquired?
the DSI attach path requires the bridge to already be registered for endpoint discovery. The window where a concurrent KMS drivercould attach is extremely narrow and bounded by probe completion. We'll leave the current order as-is.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260916-lt9611c-v7-v16-0-c65042fcd245@oss.qualcomm.com?part=2
