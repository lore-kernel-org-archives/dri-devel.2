Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451B3F55808
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9505210E160;
	Mon, 20 Apr 2026 10:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="II5zVfvr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FpIi8y+k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DB710E160
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 10:45:43 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K984Ot1600571
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 10:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SfIWXxBkhLxK7u2OhjehCJ4A
 X3QgUohHA6Ds0OvA4qY=; b=II5zVfvrImW1/W16+tu7Ys5mTvfMSSOhWKbfTo28
 vFiqqP1/kgXK2ViipP1qsgV6H3e6ZTz/htAEDQZtiqr0EJybyRs3nW+ZxwuLwkgn
 D0Snrs/5Eb34ulr+5iQg0fTyisLq8DyABY7ckOxmI7kXkF9NOZ176q28dfmcTeaK
 zHPYTkYyXIGeDq78Q+SqZxaYaV/7SJtDhGO2wcA/GqVqhAHLw2HDiDBE2h1nbJhl
 hOOWC2dHLjKl7gpRre38nfkS5I7lFNzqWVKTBkm8HRhpw5JFP3pL61QjvpsuoMRA
 PZ7z323mocqA066Ot2MbuyYaDm3rxGp4h2R1ZTSWe397uw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh898b0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 10:45:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b4530a90fdso58200945ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 03:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776681941; cv=none;
 d=google.com; s=arc-20240605;
 b=MT4m9piri+qaCxD1lOlfBJvmVOylm7rFrhu6ZQ+2J3ofH7cP0vY4wc9WnwWsHB+dp1
 TtBzKJsG8NX7X15yUQKuDndBvkOmaC4W4HX8m8SDnlybFFRmOg92hrAC/T/bOu6Lri2p
 TJ8tK8tt1/qLIoqyRsFGfGs8190Ekv5J+u1mTbUPexR7CFr5+Ap3Q37iiw/CFJz9UUVV
 SThcvazbHMnen3WEWczYJJ5WW+OdeotlyMIyc8OYq/r3GziZ1RCyIHSl7PqcatzkaNZv
 jJis8euGPusvkfA093b5xb1lAllV9zQ7hMN/ddnMjV27gQTQAUBnY75ATs+f+R45Szak
 odNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SfIWXxBkhLxK7u2OhjehCJ4AX3QgUohHA6Ds0OvA4qY=;
 fh=5TctOrEU/c74+mfhplewuCp5f0qGuHij5g9TVTL3E7o=;
 b=AF5A96d2JJcYpvLIV52Yae5JTNdoGg5hSafljOFtSsw98nznQM/M4sKq9Wd0cCPdUV
 n7YMb7++jKaMc9qvLVnZVTAIOUV/m0+TBnY9T8Th/EFzOsZqzpwTxi9whvFZmHTp3vRk
 nF56r4al9tu1aEN9cyZREYgr/1L0hvbei67vqWeIXT9swGoEI/vjZDJjp4hEc7DLfWYb
 NLnt3OApqFGniU0Hgkr0BvPuNPE1bla07JDFEMToPzF9s0IY2I/Le+4Ksmew6HL0b3pL
 8E0C5ziSvvLGsRNhjD+ln35oCh6L1vSSS4/U0KZENL1UsV0AVIMRALJgJRAgEhliTtxO
 hHCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776681941; x=1777286741;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SfIWXxBkhLxK7u2OhjehCJ4AX3QgUohHA6Ds0OvA4qY=;
 b=FpIi8y+kgidwagy+3i+tT8uInbWNVxBxXz50fBKvR471g1obrMhL3apkxoAG1NPy2u
 A974g0esq7BHkTqto81l2CGprd/1JCrT8Wnm2Bzx9zusxMUcQJAL5ShRe/YLbrDzZ94D
 nnEFA/EEgil2q7uuvhOZOBUd4ApWcp7G6KWS5xe1mASmSMmlRF3Bv6U/jOCx+ywBcYbH
 LIIEYMsb802ReafEQ/qxItbGiVSHR0YzmXGyeggjyf/6d1+6sxGlnu83IUDxZzbkx1bf
 MQO3gSwRT3qN7KbTrFFpaL3mWo1Dd/g3l9VVPHsCXe86YgnZ1OxVdNk/vJaduR/anD62
 l1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776681941; x=1777286741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfIWXxBkhLxK7u2OhjehCJ4AX3QgUohHA6Ds0OvA4qY=;
 b=eLHb/51xjLlox2OpMbb2rdIH3AQ+Q+7SNNoMTefETwPPnqzXKqo88kH+qzPvx76tuw
 w5Jih/WQq8h5CVEJhgB3/zDj+OyfNaEj6SagZi8XLkGGRJNU2OZVf+uhOjC/8eOCR3PS
 PbosQiuVLYKmWD4sQYwJAzcmoz205qOuDCHWytb+JBipazd4uqSHYEqSq6t+MoiMUrqD
 KkQ+e83oCdYqrebS9y0WDBghB3gv75nKmsviravBPtg+nBH1gyhmlcqxQYD6Ya9ZY/GX
 jpMFLWjjJesjtVTIfUOJpLxTS0BqCQnVPgbnrEiWojDBbBZbiV9XnfbQNsaHYPp4edu4
 vusQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/exbhrvRC4VP8HFGnVCvQtwTCF+GnpjJsa/l0vKCcyXsc5a4v+hbw3Or3ypxK7dbYz8ryYQoli9Uw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQHEWOmdfwwzTC5VM9sHRN/CopX4LWN8aq6RI60c9POeVWM5OO
 8GWLuHLpCIyJzkzmo9DbFtkI44PT/vzYMJQw6DAticTemQM3Nlokvltiv+YiS9EaU/aC1sEbV5A
 4ZqHyxP3qd8NiomxrsaZIje+K9SgSniykrMca003ta3DM3/YoA2osLMUm+IUhKF5vxii1XMv472
 Cde6xG9H9TlSW4IBlbZSFxOT0v2XAquyHYcXJ1aXrt88H6VQ==
X-Gm-Gg: AeBDies7dUS9nrWI/urtcBXn8CFSvbm2/dPhVI17xQSf5cRUqWr0/Eu5xiwqvXkJMvl
 CRcTpEmg4w7/MlPav9bCUw7UZDKmq9X4GlGN7cjsiEbIqXQho2gud00oT3pDKEX2QBGU4sMOMQ6
 UXf3PAxZrV94lxJYFbaVf7bU3yn+YUytSgnQKlwTbkGGAKz/wcgYSBdAAZlhW3WBwzDgwOwXhVD
 nMkX/tjl/qPf8o=
X-Received: by 2002:a17:903:1a88:b0:2b2:4c92:c389 with SMTP id
 d9443c01a7336-2b5f9fe62femr142505725ad.34.1776681941179; 
 Mon, 20 Apr 2026 03:45:41 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:2b2:4c92:c389 with SMTP id
 d9443c01a7336-2b5f9fe62femr142505345ad.34.1776681940640; Mon, 20 Apr 2026
 03:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260420061644.1251070-1-syyang@lontium.com>
In-Reply-To: <20260420061644.1251070-1-syyang@lontium.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 13:45:28 +0300
X-Gm-Features: AQROBzCoPw50l9Eoh8SJoFxfLCMiu3F2VqJVupemyBK5G7servJzS1gldue1GlI
Message-ID: <CAO9ioeVFHn3ARCqL0NJ9jRCJV2P9-Ky2c105iF7EwLUG-cV-QQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add LT9611C(EX/UXD) DRM bridge driver and device
 tree
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX9rik9mCsHV30
 F+lIvkw6jnhJR257mfwTnrz7qam+sbMFmBrknstyWs+7VCu5WyoGa4S3uX0FNBiudZpB94LPhW+
 iwC83+chYBpPgxCnJs5nd2Ov6wbNQPcqdNJjACXrI2aKl8Nka5QtDtSOrlEw89L2sC8oS3JyRw4
 tXzTs9TdxEEu8n/Akh1S91ifgJwDM1jIJCXErgqCVNFcV6cyp6WKcYsGw2cjPUcef31cL6YZtxd
 A+TBTy1NvLwF2cWIDUT7u7mWThGgKqu4HQ0NmhATZpA3nR/szUubs+FJqkN8RslghqsTs5rkJJW
 5F3Rsx1IWE8yOl9A3a8YQQdUfV+0xT4JCDiHCNojRvcSpQvR3eqBiz5k+yhdIdg78wapZfl60Ve
 MD/o+FjpQXrdAblh3q/LbzjeOiOIp9JeB3/Z4rdIsjRtLWrD3YUe/PXaRpFW4XuSY7ACAGOPpFx
 PBTyz7Aa63l6H1zfPEQ==
X-Authority-Analysis: v=2.4 cv=D6B37PRj c=1 sm=1 tr=0 ts=69e603d6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=JWicuObQ_znxCAsEpPMA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: wLiZrVmY6nZcURtAjG91WgzS5diQqmWB
X-Proofpoint-GUID: wLiZrVmY6nZcURtAjG91WgzS5diQqmWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200104
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

On Mon, 20 Apr 2026 at 09:16, <syyang@lontium.com> wrote:
>
> From: Sunyun Yang <syyang@lontium.com>
>
> This series adds support for the Lontium LT9611C(EX/UXD) MIPI DSI to HDMI
> chip:
>
> -dt-bindings: bridge: This patch adds new content to the lontium,lt9611.yaml
>  binding file.
> -drm/bridge: This patch add new DRM bridge driver for LT9611C(EX/UXD) chip.
>
> Signed-off-by: Sunyun Yang<syyang@lontium.com>

Once again. Your messages are not reaching the dri-devel mailing list.
Please fix your SMTP configuration or start using B4 tool and B4 Web
Relay for sending patches.
Most developers wouldn't even see these emails as they haven't reached
dri-devel.

> ---
> Changes in v3:
> -dt-binding:
>  1. lt9611c(ex/uxd) content merged into lontium,lt9611.yaml
> -drm/bridge:
>  1. Drop the licence text, only use SPDX header
>  2. Sort the headers
>  3. Use library functions for crc8
>  4. Drop i2c_read_byte and i2c_write_byte
>  5. Lowercase all hex values
>  6. Use paged writes as implemented for LT9611C(EX/UXD)
>  7. Drop dev_info, use dev_dbg
>  8. Modify lt9611c_get_edid_block, don't store EDID in the long-term structures
>  9. Use HDMI audio helpers.
>  10.Remove unnecessary flags,Implement proper cleanup path, unwinding resources
>     one by one.
>  11.Replace devm_kzalloc with devm_drm_bridge_alloc.
>  12.Remove extra kthread.
> -Link to v1: https://lore.kernel.org/lkml/20250903123825.1721443-1-syyang@lontium.com/
>
> Changes in v2:
>  1. Forget modify code, operation error, Please disregard this submit.
>
> Changes in v1:
> -dt-binding:
>  1. Submit the first version of the code.
> -drm/bridge:
>  1. Submit the first version of the code.
>
> ---
> Sunyun Yang (2):
>   dt-bindings: bridge: This patch adds new content to the
>     lontium,lt9611.yaml binding file
>   drm/bridge: This patch add new DRM bridge driver for LT9611C chip
>
>  .../display/bridge/lontium,lt9611.yaml        |    8 +-
>  drivers/gpu/drm/bridge/Kconfig                |   18 +
>  drivers/gpu/drm/bridge/Makefile               |    1 +
>  drivers/gpu/drm/bridge/lontium-lt9611c.c      | 1365 +++++++++++++++++
>  4 files changed, 1390 insertions(+), 2 deletions(-)
>  create mode 100755 drivers/gpu/drm/bridge/lontium-lt9611c.c
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
