Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C85C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AF110EB16;
	Tue, 21 Jul 2026 18:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p02EeJxV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DAthBagQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAED10E1DD
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:47:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2WCX2548706
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=AlT487GjgIuItMOY/9Z1aN2h
 x+ACKb8H7eDtCUp9i6E=; b=p02EeJxVrgZk3DaDlRZ/z97I7DX4YBz4l2+BQJLj
 ilVzwXuLHWycF158bJN7kJHVKSYgu0DLz4HqodhybyftbTnNaqTFP+Cd/kSGWzEB
 eJ9WfqnmGCIWPNRm6tg4CnGx/q8Lq8bXi6zYUD63IpHZ74EdACzYBRnSSGkvu84u
 5lRF3Gc6msOgVP5xSzq9sTDDiQ2xAfnGxVUvQGEbSM3afrqiVy/mO4o+agLaHQBv
 pPjoGiYkVcY3jrrYxgdBIclGpntN+sIpQj6iw4jRtBgdP9uYoqhPXUe3+F9fjhNe
 rK5JAfJl/hs4A0hgVMvtVLVG9OumuP9itb65BDrtC5S78w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3jfrs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:47:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c19493ac2so15704301cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784659674; x=1785264474;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AlT487GjgIuItMOY/9Z1aN2hx+ACKb8H7eDtCUp9i6E=;
 b=DAthBagQjHDkZG/CXyovcQTScOjkftd0Z53yGwJlSyw/UPDBipwq83B3v77EtxpkUO
 kfESenG4SnoV3qO9ZcN+5Fgb+KYufzYCVY0HoxSlRHCfa+hlmJyhTCA8HAo1g8Bzzh06
 VgrbvNCxoVV2JGswxYRwNU+ugj2RoR1kRb870QBbh1p0ZSvlxCQ43ysbLFuQWlM788CG
 rCBaGVXfVwU0r+kCPpLR0j5jN9dBVC3vS5QesUzQGdE+Dj78JE/Wa9FTNtw5JSjPABRD
 rSn/VFu5T7ncP42ok0ZSeR+owWYqqRp+IBJBj633R4s+LHOAu1wEN0f5514yrIJpSwvw
 aH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659674; x=1785264474;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AlT487GjgIuItMOY/9Z1aN2hx+ACKb8H7eDtCUp9i6E=;
 b=L8tEZRUnHoyHCuyJ2B9QONQkFWxvhhX66eLmRfgZ+76iif9sLcLQNCaiXttbxdXUwQ
 bcoZF7xjODt4vlWdWHit8BbLzfEQyg2flt1KpUoxujUaHkkz/1A9skSLUPxXKpvD7VR1
 zqqGcRIqou+51GS4DqAIece3Gi0AlElTB30HzTnF5ClQvaN3L1uE5igkFljMynsrz1zC
 s6LpKIvoAgDen5ps4KGKFnwZFhu3wn6GB0/hIXeHFnS2foQK4q2SIDR8sKSPV9TUgXYQ
 a2dHhyiRF+avm2NsBQE6y5Y+sy3fBzklHDDfaGEAyZJ6ToqcdgaKmmkiL1mvO1H8HLUd
 FE1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqytxCD637EZRfoxNX3BtLduou9MPyw2Dv2t5K2sDG1Dv2zqAgJcK3Ozc0SUt9EANYpdDBSHxUbujM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzbMATacD8LjXHMhoP2oCjYRemyQVkVz+3/9bRv6qShpi7WMEb
 1HyvqVdE06QcvEwcwSUYyJsuW1ZNh1F1CeukkrYmPFIA31fytCZzacXu5Ym6KQkVTvNcDXRu6Tk
 TYd6SXIWbkP2yZcWjjqNSBoqoK+k6s95Tamt7x9FHj2f3rpZk6df9alAMU7gdpXHn3HxVII4=
X-Gm-Gg: AfdE7ckcN8//Jz3zKA/h7gvw1IQdtpT6Dxa+5ifIVLYhKeJOX96wrg/0xmGCaNNG7B+
 lsLYvFmwlh8KXSGXDRSPD9Eh5vGmoCx7mp+zU2f2/urpxwgZY6QZxedIUapGoGUL3T6edk8Thxz
 7p8nqQosWxftP6QQLhWzerjzpOqVb52PYiUd5ZroMfD5vElgXEHnPNGJlPQyG7sKLx+HHsIwFT3
 s2FDcJS5UUQFI+xFrjMPYRtRrxvRaAC2NxMqJVfiRCZ4IsIoe9TZbiWAeSD9+TtNmwWCHXc1+na
 NSXB+G3HexkJqXY0Vo7a/8Dhmwq9ti3TSi2lExaKUFdh3Z624wcCLrJMlL3cS3lkmLp6vj05pni
 JgnbH7ca+i0msO2JvjjJx9gEWZvwn7sd5/YzPhDyNcoQ163+dU8f1amm4Uu0nbjslghQvWint61
 jrq9KYx0AcH1aI/A==
X-Received: by 2002:ac8:7fd5:0:b0:51c:7b11:41ad with SMTP id
 d75a77b69052e-5213ed76967mr189500931cf.73.1784659674519; 
 Tue, 21 Jul 2026 11:47:54 -0700 (PDT)
X-Received: by 2002:ac8:7fd5:0:b0:51c:7b11:41ad with SMTP id
 d75a77b69052e-5213ed76967mr189500591cf.73.1784659674039; 
 Tue, 21 Jul 2026 11:47:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9e45fa5sm70740e87.66.2026.07.21.11.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:52 -0700 (PDT)
Date: Tue, 21 Jul 2026 21:47:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 02/15] drm/msm/dp: drop deprecated .mode_set() and use
 .atomic_enable
Message-ID: <ldznbgwysgo4ya6h2s57wytjjhhljkfyiagrce4z2gvty5suye@bdc3gfzl7xff>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-2-bea261bf4e7d@oss.qualcomm.com>
 <20260720063317.CFCFF1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720063317.CFCFF1F000E9@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NyBTYWx0ZWRfX55acWThQRed8
 A3uFKtHwXr89L/tTOd0+jOEOMlAFCJAkq5MDORz5Du6ro2d5lkEtf2GyTCOrbE7XNhh8OAqxycM
 Qz680wW8oWn2S3ISbUK1YpRxTBNOqX32SMWZzC1RJEASu/p2j1U+Sq31AUbdl2g9Pp6A2dR9Rlz
 MpnjTqXY+PTKUhl3B1vLrPTeQNCPiusjl1jMbTv5K7/1GY1FoQ7FW1QMIwQzUoGUa0Wxu5gorC1
 gSN/SIqg4aCHqSafeHkiYNYDUkZN4Xb2nv6DwFnjhNS0Zzn42v6jQiw11oJCrnH9DDZ03prpu71
 Ak+irFeR+23F18/PkeKDjISZQLNemt2m2ErxXMb/rbwfH/ANVTd8ddt2Q0qUdsPwTDvbgyAcSYQ
 tD5IF5Uxokez841dOj7Mw0D5A2IcgUoxvbY3JxjxOokBKrj4f31TVFycaFd/tC2IfSNMWNy/t2U
 LGR2Pvb7YqvljW6u1+A==
X-Proofpoint-ORIG-GUID: qSV-JGut4AdctYFO_LGyZbUJCL2qE0Ln
X-Proofpoint-GUID: qSV-JGut4AdctYFO_LGyZbUJCL2qE0Ln
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NyBTYWx0ZWRfX01M7howZIbNw
 LDf4AogY+iqsODLF5isNTrrIX4H8vVgpJcNrCG30RUgMmN9DjfhHWdBiCdA8ixz3+yrBfwb2+qC
 tAPR6U1ZZsZAbt803l22s7J5grMK4ow=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5fbedb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=10R1qcJeZEgYezoHLQYA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210197
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

On Mon, Jul 20, 2026 at 06:33:16AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Moving mode state updates to `.atomic_enable` causes the DPU encoder to read stale wide bus configuration.
> 
> Pre-existing issues:
> - [High] `mode_valid` incorrectly evaluates wide bus availability based on the currently active mode's state rather than the candidate mode, causing valid modes to be rejected.
> --
> 

> > @@ -1386,7 +1406,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> >  	if (msm_dp_display->link->sink_count == 0)
> >  		return;
> >  
> > -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
> > +	rc = msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
> >  	if (rc) {
> >  		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
> >  		return;
> 
> [Severity: High]
> Does moving this mode setup into .atomic_enable() cause the DPU encoder
> to read a stale wide bus configuration?
> 
> In the DRM atomic commit flow, the encoder's .atomic_enable() (which executes
> dpu_encoder_virt_atomic_enable()) is called before the bridge's
> .atomic_enable().
> 
> Because msm_dp_display_set_mode() updates the format state 
> (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420), the DPU encoder will query
> msm_dp_wide_bus_available() before this new mode's format has been stored.
> 
> Won't this cause the hardware to be programmed using the wide bus state from
> the previously active mode, potentially causing display corruption or a blank
> screen when switching between RGB and YUV420?

Indeed, both look like an issue. Please add a patch before this one,
adding drm_display_mode to the msm_dp_wide_bus_available() call. It will
solve both issues.

-- 
With best wishes
Dmitry
