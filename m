Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22718C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D6710E43D;
	Wed, 22 Jul 2026 13:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ff759zIi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UyMCCrIl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E685E10E2D6
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:11:11 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MD1xTu374219
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hNel+sH6BLQYpHqz6MzLUF1s
 CFWsXMBglCiWNwb42E0=; b=Ff759zIiXFr+0AKgsg8AcULIR2Nd9Ll3eNjanZ8l
 tTInjYN0hwb+M38DnZbFSU2+F8dropckOfxw5nMZpOSAwcwAKU9RotA1JfIAoRkH
 RJAg81gUBoml5L73DVlWcNSM1jPM/Q8p7ffaUP+WRAoggR2thQDDRg7AEaUUH86j
 HYZU1jBpE8vb8hf9/FMYbNcIgDpnLEL8ozxNMgOOZ3D7b+BUFdIbQXWE962sx8Pr
 R1SeEHXJy48bAD9N45tPRHFkL7AvFZ8D02xaGPEtUJp4rkGfmJubJn75e2qz20l1
 5n3AThYVEhEeqERhe9hCPRvloXPbFuJq8vsIPFSxvpIVYg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6fv739-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:11:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso30095041cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784725870; x=1785330670;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hNel+sH6BLQYpHqz6MzLUF1sCFWsXMBglCiWNwb42E0=;
 b=UyMCCrIlHJ38wo44j0xocwHtM0l4H+yFyMr0WWAAkcwr4dnFHlawHz9iES7Xmy+gYk
 49hcgnLSB8ZMVScIDmQHWFOSDVgbmG//zi7H8VjoRF7Y28xJa/Fj9BDdOudEJ0v0gi9f
 ypL6y12/AdBfMyzpYT60XeAl27d5unMwXK0d9kNSjklGlTUGSpUWbjNT+wrX850An4tJ
 iZaHYSPIF3tCTUvFeRiO/M9D1XqGwG8FhAF5+3aaKtOxKpRQ4H/wEEel1x2xpA/VRSH2
 B5yFyNp+xHJZl96sXFfozg+ULc1jz8VxETAa5NvyNVqR+BunHTTWC7IqTXus5KfEVIFz
 v7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784725870; x=1785330670;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hNel+sH6BLQYpHqz6MzLUF1sCFWsXMBglCiWNwb42E0=;
 b=Hp9tmm6efyIxbVBtRiA86lzEyNj6Gf1A/DqZPUrodLioeGWb1ChUiv+9pdDs3RN7tU
 DSY6eMBOLohtDm12BJdbv+vKsfm+lnJkjBPosq+jWwx2b/WQhDub+vXFeOpqRpjR7uqh
 U8kngIEh5P27F0y//jgQDRJ+JERmUHOv8C0Ho5M+cAJMGwiqQaq456HDPfr9kEx/7ra+
 APUchbEOdWuRkMIy1ydC+be5bXmZmR0zKywLvtJQF6P8g5cWSg05La1pU05EZjcBgIIz
 1QIWfqaOwonPEkBbBHUVJfBFXKWEviR3t+36091QJQTts0LxP+IYhca7S/8tJYVTwARQ
 UEnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrx/GUdu+Z9XzyZ8+hnZBhh4d+xgXpLujxLXQEEWg8Zdl+mGZhw0ywgPaRBiY8S5AZBNuC2eDuIDUk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBqc/WK9xqdZRKKrJDNe2YxlIwLiS/pF/ccf6QjXh6YFPtSPXQ
 YdYQN3HPqstY1ivsOz+jQFqB0eh/PLwXE31DZTPPub+a+Ebul3UduFVot5sWruacF7/3KyKE0ul
 a7O+G1WW6ZXj1m8BuA6WemTH4DEber4gypiHRT1zSeo0RS8g9rT2yttmfGjlNa2S6l/A9geMgK2
 1oxcE=
X-Gm-Gg: AR+sD11bNXV25t19wHEi0xBcnusMdNqB/JdMo6hY0Bb4qqcoBLiZgxc2FY74dXFI1/Q
 HMoBpL/l4++IBqp8dOC8JRpkw2UTlw4mMg7MpfSv6dk/miOqubhFNGjQ8kVO2jJf/H5OUPGK4UO
 uFLzXFdAwmrO3Sia8iehpYsXjBg2jlpbtpvvgohretHw+KjPA5SWDypfV+/I5eZtfmk5kazHUwv
 YNJRRN2JXpSoP/Rdbh5c5rnmFG0A735QBgHr9/meCgZhssJwMHu3Q38G+9RyrE4gwzjEiPfQefY
 umfMHnaJq8TRjRNZEbqoF5HPA0ahkfJ2xTDx2IYRsdJBf3y+xZga4DwF8hq6xvK/Hk5AT2DQFe7
 +8A7yUi3EM1qkKUluzGqgd4dEGZMUCBQR4zH3iU6mORGBNnzHsQrPRaLRSWWm9fCAJOX4BVvOdE
 Ui5mrSwEyPJ5N+BA==
X-Received: by 2002:a05:622a:310:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-5213bb216bcmr213870061cf.16.1784725869568; 
 Wed, 22 Jul 2026 06:11:09 -0700 (PDT)
X-Received: by 2002:a05:622a:310:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-5213bb216bcmr213869091cf.16.1784725868719; 
 Wed, 22 Jul 2026 06:11:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9d31c8dsm457423e87.43.2026.07.22.06.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:11:07 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:11:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 02/15] drm/msm/dp: drop deprecated .mode_set() and use
 .atomic_enable
Message-ID: <i4h4amxstadjomfd6i5dkgtjdnre23ugewvlsffajfdelwmyfg@kpex2duwixxl>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-2-bea261bf4e7d@oss.qualcomm.com>
 <20260720063317.CFCFF1F000E9@smtp.kernel.org>
 <ldznbgwysgo4ya6h2s57wytjjhhljkfyiagrce4z2gvty5suye@bdc3gfzl7xff>
 <fccb4620-d5b2-4a49-b703-8725a863c540@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fccb4620-d5b2-4a49-b703-8725a863c540@oss.qualcomm.com>
X-Proofpoint-GUID: AkWV4WSOAioxr1LdGK72EVMDHzh3jovi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEyOCBTYWx0ZWRfX7Jn0Q8uGBf93
 BYt96Qtt10narstrKsk1gnJPuUxDqx1G9K0IcZ+xKP/YRiNopuSKqLZZGyZOFD87znDYrmlaBoe
 MidkjdgyG8wyTzmyNNN/iAyEWnsOTcSpR/I/7ns7AzHtxV9jRZbExKAVesNk9bwhRWtIZdNPIwN
 T8ek2mlf4AZPPzEgVg4xTtVb9gxN1n8yaZe9IHNRloMsPVaC8qz88PE8R9W5z9dptPxAflI2473
 ID24v/vzS32ThEHR0F5aTOAocfCmKndLt/gL4DH/UPCzptRsQTpOqFu8K7zFvCFpgnIJw7Hatj+
 xjSv6M8f5lf4fbhvfIapoO+p/JeXu4pu1CnouU1KU7w3VBuSr8Mi+X0NDGdwqQOIp7I5IPxBouz
 piuPVOBzyjohM1mrtfAJlqUeoC+skJEqzQHrPkmXZfFL4nKqoZooksAcOtscoyyrm+UuEIzF8/C
 Dz0O2y1IMGG8d8tlGaQ==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a60c16f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pafepFX888BrzEi7t0oA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: AkWV4WSOAioxr1LdGK72EVMDHzh3jovi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEyOCBTYWx0ZWRfXxG+NPRVAprBq
 g8Pn5oP+yYSXBDKJLpaPyGQjfv/i6afFQUvnTv7vkoD72eW5fy3sEMv5MAnD+UDo69NfigAQwDh
 VZ2qprYHl6DoeIu+06P1m5ItYaXsoM8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220128
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

On Wed, Jul 22, 2026 at 06:54:56PM +0800, Yongxing Mou wrote:
> 
> 
> On 7/22/2026 2:47 AM, Dmitry Baryshkov wrote:
> > On Mon, Jul 20, 2026 at 06:33:16AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > 
> > > New issues:
> > > - [High] Moving mode state updates to `.atomic_enable` causes the DPU encoder to read stale wide bus configuration.
> > > 
> > > Pre-existing issues:
> > > - [High] `mode_valid` incorrectly evaluates wide bus availability based on the currently active mode's state rather than the candidate mode, causing valid modes to be rejected.
> > > --
> > > 
> > 
> > > > @@ -1386,7 +1406,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> > > >   	if (msm_dp_display->link->sink_count == 0)
> > > >   		return;
> > > > -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
> > > > +	rc = msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
> > > >   	if (rc) {
> > > >   		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
> > > >   		return;
> > > 
> > > [Severity: High]
> > > Does moving this mode setup into .atomic_enable() cause the DPU encoder
> > > to read a stale wide bus configuration?
> > > 
> > > In the DRM atomic commit flow, the encoder's .atomic_enable() (which executes
> > > dpu_encoder_virt_atomic_enable()) is called before the bridge's
> > > .atomic_enable().
> > > 
> > > Because msm_dp_display_set_mode() updates the format state
> > > (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420), the DPU encoder will query
> > > msm_dp_wide_bus_available() before this new mode's format has been stored.
> > > 
> > > Won't this cause the hardware to be programmed using the wide bus state from
> > > the previously active mode, potentially causing display corruption or a blank
> > > screen when switching between RGB and YUV420?
> > 
> > Indeed, both look like an issue. Please add a patch before this one,
> > adding drm_display_mode to the msm_dp_wide_bus_available() call. It will
> > solve both issues.
> > 
> Sure. Will update it next version.

I needed to pick up your patches, so I ended up looking at the issue.
See https://lore.kernel.org/dri-devel/20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com/T/#t

-- 
With best wishes
Dmitry
