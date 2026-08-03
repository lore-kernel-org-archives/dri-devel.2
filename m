Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CDEC55196
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 19:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618B610E075;
	Mon,  3 Aug 2026 19:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZi6COh9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B365hLuR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678D610E075
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 19:17:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673HB5Z41237747
 for <dri-devel@lists.freedesktop.org>; Mon, 3 Aug 2026 19:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KRPjAdCw6C93bb715vQS7riK
 2PYzmQqIqKXKyNnULY0=; b=CZi6COh9Eq4EzDR3dgJRaTINRnCMPhwhIdBt5ktI
 NWZnSTIP/HWUjN7T51i0xFz1eoQHm2jb+S7txkXswKD5RugG6csF1nRW/joRV28p
 1sq3A3Ds8rY/Z43cx3FcZNWorSTDtUB/YNsIjgnk16seMWqngHpAhCAIwDcSW0FZ
 /saV6RN7hVxu4/LjBZSEo4uoiKQr/7+1LpG+5keWHyb4HZzxQUKtYpD+URSHfo49
 l2inNXVAIi4Mgi6VEM/VMfrb535IACV1Lze9eabbYpbtHnPHbuzAKpET99zoNKZM
 LbF9QkbZgQWoay+AOPon9qNNqNWc70oyw3K73c8i/CfSkg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty5s8j23-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 19:17:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so200966a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785784677; x=1786389477;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KRPjAdCw6C93bb715vQS7riK2PYzmQqIqKXKyNnULY0=;
 b=B365hLuRkqrw5Eh6PDu6DPeqlyMpD3QTPbftt64FLEqvokWwcVXML2hZpQXA+6Y0gg
 Q4hvq+Xm1pynYetA+K6AEXN0fx9tNbLgzG8U/A0fOQ0m5iJmeHZIhBHFwjlg2ztlA91B
 G8VqCQ3+rHen3eHh5SyIwOkdjpumwu2fFDPGMzk45lFocI8u3r2DiKceOFXaun6B4tu/
 SNOzt9JDJKe/CW67I0kFs1ZpS9kkRMkgax4R06aZqmtqkJhZh3KYsGNof650kkbb+0jE
 POQTZoZo2Dm6Zfll8NNGXEsy4at2bSvrS+ud7hH2ht5KamS/1APM41hkx/dldMZLLN2s
 cjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784677; x=1786389477;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KRPjAdCw6C93bb715vQS7riK2PYzmQqIqKXKyNnULY0=;
 b=rs66k+coKZ89O+bM2T3BWgUKwgiQXy4h8aONpV9ZfepMBNs6ajH5b+tIwPuWVqlO8d
 UKzjhvHk59rpoxgC0HuPnUGIYw1+XeoN82BvOiimkO+y+MC3g+djswI5gFJtxBgQkR+a
 Os3IgAOKNSKFQu60Sal8j7ro5ngGTdTffFJgloZ5Mc+vJfdA78F3nOagPaHKGAREXE22
 qS/7OYV6EN55tKxn8283Sqv+A4qz1K5HdXmaYIFT4ke8PkIYscNhr1RruwVBylC0Lhh0
 ob4Yvv5DCxU9TxhOGzV/KmHCLudzi4Nqbtt+EWhAwF8abOfzDEJ6x3ic33hSMWUYfmaa
 Nn3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp14xZgZrs+P3xFVXE4G30V6PQxCM+gC5iyJe0ACPO9RhDY/SbV4GVVoak6hG3FkWt+z1UjXCt32oc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoGBDjz+7jrX2y9IaQicYwqf3AHpAA1m40x02lJcdPMeei5BmV
 8JWhfuKEnmmSp6/o2dc3Biqo73z/fWWRRbnDKPtiQGz85Ipl/UjzwLRD0m3kuG3ZGEGoPZY8qJG
 Ka0Lk1hHN0rmgsAgX3f5NidT1+fv1JKbJRTi2W+8C1Oikk6e3CVCZxC0tDpExNo5qCJF4N0A=
X-Gm-Gg: AR+sD12/6rGFvvS2/CDyxPgJuqTCP0bcQA48T23Y+CwIdrfxa/vvcnukAHAuDmxIXus
 EiLlStTfk7cEz34MCxLRNSXGX9IwL2Jo1GMPFfi1odReWTMdYGtYtrwjzZOCG1SxzpaS9zLCoXR
 ugZDpjgVaHAZsuZJy5Zg0xmUFdMJfSfxtmOSGyvMuEYmI2Qwy30seuIzNIGYmGg3R8rgWoy8AwR
 9jrTKneM9Ve+FqFvz5gGYpbuxcf1MbUxTU5sTGRW+Nq6ExGWjAe2N4+Nr1HTwR3JWohiX3ntkZk
 34G3P5YMkhQr7bWjOttUGu5OuYd7ablx5ELo+YMy5WZCogVTVVyoDB7kcSVZBFJAnZcdaK0HRhb
 JKgKJ6G4O9AwShHLAxY6JV0nAEA==
X-Received: by 2002:a05:6a21:a517:b0:3bf:9e85:b423 with SMTP id
 adf61e73a8af0-3cb6ca94992mr635517637.34.1785784676965; 
 Mon, 03 Aug 2026 12:17:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:a517:b0:3bf:9e85:b423 with SMTP id
 adf61e73a8af0-3cb6ca94992mr635493637.34.1785784676491; 
 Mon, 03 Aug 2026 12:17:56 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab25227bsm33419253c88.7.2026.08.03.12.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 12:17:56 -0700 (PDT)
Date: Tue, 4 Aug 2026 00:47:50 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org
Subject: Re: [PATCH v8 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <anDpXv7HXgHPI5Gh@hu-mdsor-hyd.qualcomm.com>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
 <20260728-lt9611c-v7-v8-2-bda216bfaf37@oss.qualcomm.com>
 <20260728112614.BF6721F000E9@smtp.kernel.org>
 <5xpvwwovgwuxltjqjnlchamwcvppdc4376fcujeqovm7fr3uhw@6r55ztlq47ob>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5xpvwwovgwuxltjqjnlchamwcvppdc4376fcujeqovm7fr3uhw@6r55ztlq47ob>
X-Authority-Analysis: v=2.4 cv=SPJykuvH c=1 sm=1 tr=0 ts=6a70e966 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=CNQlw8xw5aM3HEDaa78A:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: OB4sC3s8Iqonb0NRpHVq9S3pb-k98810
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE3MCBTYWx0ZWRfXwJSud9DPvuQP
 cN8ioWQItaL/b+/JdoRNcy9dNLPf2dy3yJ6wWlAru30ER+sTfgUP+ZdxRDIxDefADlNww+e4ceB
 Op34khrdiQrYELBWm9jUooNvPdqb0tFy4T9Nl9VWs0vLIyfH3rpzHgTulPROKwMwc2xlJB5rzB2
 Bs9tLnCofsOqtQhX1P9sHKU5u2xkQ3ZyLMrr8dZRjfQ2ipiX4GgTIVyDzsgceg7LekUUVgy5aI0
 iG/V4VtzrowS0GsE1O3v1jqloxOXHXQBnhd2X3E+fodP6oc1dwO13k6egXR8n9Jbp3JH/oLFpum
 lhfcRismX3A76XwHIZP0tjfZd4mgzfd6pjnkUOacZH914lpv4XdRSDFpXENVPTa4VReGNOG50aU
 wKzeXrGqN2T4Qblg4NWrymLPexhPmVluVQjt2WxTYMwG/WUu40M7gNkuNhj8Ic0i5s3yZ9Fbm59
 qu/D5BwSgokUUCWuUxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE3MCBTYWx0ZWRfX+h4Dul9ymhU8
 aH2tqAYSaoz1oZwVQZkhMFBViYjO34glRscB31N8wlMofHyKbi+CGUxC9+iykmFT0zzMCgPE2ur
 2Z1lb+KbETmU3IATH3kW6GjbqNqsjBI=
X-Proofpoint-GUID: OB4sC3s8Iqonb0NRpHVq9S3pb-k98810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030170
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

On Wed, Jul 29, 2026 at 05:05:15PM +0300, Dmitry Baryshkov wrote:
> On Tue, Jul 28, 2026 at 11:26:14AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 12 potential issue(s) to consider:
> > - [Critical] Recursive locking deadlock in `lt9611c_hdmi_audio_prepare`.
Will fix it in v9
> > - [High] The IRQ is enabled before the hardware reset is completed during resume.
Will fix it in v9 by changing the order.
> > - [High] Premature manual teardown in remove() conflicts with devm_* APIs, leading to UAF and timeouts.
Will fix it in v9.
> > - [High] The IRQ handler incorrectly clears unhandled interrupts by writing an inverted bitmask.
This is ok, as right now only hpd interrupt is there in firmware.
> > - [High] Early registration of the DRM bridge exposes it before resource initialization is complete, risking use-after-free on probe failure.
Will fix it in v9.
> > - [Medium] The return value of devm_drm_bridge_add() is ignored.
Will fix it in v9.
> > - [Medium] Selecting REGMAP_I2C without a dependency on I2C causes a Kconfig warning and build failure.
Will fix it in v9.
> > - [Medium] request_firmware() is called while holding the ocm_lock mutex.
Will fix it in v9.
> > - [Medium] Missing `regmap_read()` error handling causes uninitialized memory usage and broken firmware upgrade logic.
Will fix it in v9.
> > - [Medium] Incomplete error recovery in suspend callback leaves the device in a permanently broken state.
Will fix it in v9.
> > - [Medium] Synchronous firmware request during probe may permanently fail if the root filesystem is not yet mounted.
This is ok as fw_version == 0 only occurs on factory-blank chips and
synchronous firmware is better.
> > - [Low] Firmware version is not updated in the driver state after a successful sysfs upgrade.
Will fix it in v9.
> > --
> 
> Please respond to Sashiko findings.
> 
> 
> -- 
> With best wishes
> Dmitry
