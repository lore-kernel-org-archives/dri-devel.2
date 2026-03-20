Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36CD1093179
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFD210E038;
	Fri, 20 Mar 2026 07:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fzXAZ4f7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fKTpeY7g";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF65A10EA7F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:02:12 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K2XgOo989373
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=s7bVSIq84DfX2e31jv7RvyHv
 lAqc744AbHZLuKRDl3g=; b=fzXAZ4f7Uy8dom74nZOjJjQQbBMrKTEdpIAxUDQO
 6vH/1P7lH+C/hWVG2RTUSuUIWkPTj3SjI+5HnNI7S+Qz+jwzOwgWfcskJsbQHKEa
 gbEWgcA22GLFIGjIQftrvv58uoXMVMcuLh7Al59tFQcg0yD7sD0oig1ut6wXLp1a
 mGIuCXqEOFHgT1vhhxxT7U1R2GzAKVoODBaqzbY47uwZ+mGkMW7Yb/7if1MC25MA
 NdT8yF3VXq7j66OUhIJh1iRstcepx1XSzE0Kp5ogeScD/qMyRWmAlJSYU5PbQCq5
 HA5RVRKXxbXjVDUoFWEc5nwv05uul8g04Qws2GfLAMdjdQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0vahxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:02:11 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-602b11346feso844112137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 00:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773990131; x=1774594931;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s7bVSIq84DfX2e31jv7RvyHvlAqc744AbHZLuKRDl3g=;
 b=fKTpeY7gieSwYIaJetedrDApHIai9blnwEyBp3NCJGplp0ySlCOkOl4dFlyKxvMCsS
 A1x311OwHzQgq/HXo3RyWYcRRaaxx2x2z6Cyrvxqz8oi6Y/IlmxKPnRNpkGT6AKB88oz
 lzPcstx3DLcXILbIjDUNgn6pXPJAISnYTj1DlhTx0a/Rqz12iT83DNj5Eg2eEc3Po1od
 dRIuKOSnea5hrSEQBW8ekA5pO6eE6I0RCJTRhcO2DArdaMr8G1QDpL7VMhdX3vhBRPaB
 AMj+thxDiqV6pSSQSGGaOCtEQXDRSUsa0WZHqK9XzlSCpgyztyuoIJpv8OoIhrfJaKbc
 Iq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773990131; x=1774594931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7bVSIq84DfX2e31jv7RvyHvlAqc744AbHZLuKRDl3g=;
 b=R97wCFQtDZZfti7L0ssX/o9iJi2ORWBzhZ8u/eCq0QI+L2GEmBxrNUBhPlXGJSPRhF
 TVHanRyrBoMsXVNBGfv4zJCRYh7b78L/d8udq0xsV+uKJlvIJgGLbYtD+72knRNMT3dh
 clJOoKU8LSLK+XzMsJvG07DCa8eh0FaPbiKhcEocLUkWLggo6unIVwa2iiUUsynm66AP
 kw+NXCErdCjS17PRvHp6l2C7fPeg+qfio9UFmYK8kXCxtElZW+GUq+QeJpjo9PedCuoL
 a4cy+TLlfbSJBE+8Hti1ZhfulZuzNsDLPIyqR23N+7q2r1Xkeiib0N8L8fKztSF+KCMV
 3bpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmHfi5sm8xZAOL5p+M3FM4xPaq9k40CooxTz+FTI8qkBPa30Xfd+o/RqAxGM7TfTV+w/jeoi46d3w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlsHnSP4NfUPO8Z8YnkBxOt/CAR9jwWxRuOOY4vVG7PZc7lILP
 qrGHzchGVWneGguH6lQpRrS1bwoU6ivPlT1vBP2A7+3GU45K9rnIcClDiPqRxzsr1doLWfDNXO2
 8Sd09RyhYrlA3R5IAqlwKtafvt81KKffWnmv4OerRIw5whV+p/fY0L2dKx1pbo/RjoBD8ypQ=
X-Gm-Gg: ATEYQzyKZkSRe1Ips5EAUtZYNAtXbPi7aSLejLFi6aQhHWSBgMxpdXYp0KS4Jc6+WFg
 qm9u72d8bJTxsRZyO+/XvLYaAhSjt5OcEN9JI+TIMXjzzwNQI/NwTh0NLUGl7ADjzkQjmaNJ5Zk
 PRKWLaIv09ls/K0j+3CyJEx2BwlX8lCo/Z0tmMUw8hmBgRzGFSgoJeZacKleTn5tK34JthOEWqS
 hDgenahXuGMnR59haYRePZ1a4hiOUhE07RQc9OIbimJhldFT+YD+q1m8JRejgaOOKYLFncLHvO2
 l3A+TGqwmdTJjWLIpwt6mJMIBLdg8yK72VxDZ1sPfho6akCw1WdfnLhJ+sY6/pJhgrsbZE5UZ/D
 VmKsZc/avMTF8Op2hd8A55ZMIJ74YRHjnAknKs6Xi9XRlKuaRn8JtC35WMsu8bW4hO14XdwIrSL
 ZWHFZdc+8pGipRnLtub+i97v4W+PwXXRf/tp4=
X-Received: by 2002:a05:6102:26c9:b0:5ff:de16:36a7 with SMTP id
 ada2fe7eead31-602aec81966mr1007429137.23.1773990130873; 
 Fri, 20 Mar 2026 00:02:10 -0700 (PDT)
X-Received: by 2002:a05:6102:26c9:b0:5ff:de16:36a7 with SMTP id
 ada2fe7eead31-602aec81966mr1007409137.23.1773990130451; 
 Fri, 20 Mar 2026 00:02:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9ab6d4fsm3261211fa.34.2026.03.20.00.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 00:02:09 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:02:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jonathan Marek <jonathan@marek.ca>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
Message-ID: <fpmq2y4i6hjgaoiunwihsqkm5rl5eykrnwqtbtjdpqtslmy4md@yqj76vcej6m7>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
 <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
 <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
 <oihbfczsj5cg7qfjjt6jvyodjnjbezyrv6f32vmg444g5bx6ow@r54epj7ilsyt>
 <da050aad-381d-ffb7-ec7d-8ed8a80d790a@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da050aad-381d-ffb7-ec7d-8ed8a80d790a@marek.ca>
X-Proofpoint-ORIG-GUID: 57BJnw1QhgqLUd0YBq34Yi532BELmiAl
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bcf0f3 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=rjgCsHGJ4Y6OlbO_Df8A:9
 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: 57BJnw1QhgqLUd0YBq34Yi532BELmiAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA1MSBTYWx0ZWRfX/1ngjP5RhQE0
 Cg2b2J2qsL8Ly3XqOM5TrKUWNHKGkGUJ46mSErK/9Lx7Z/yZKPa8L/5EXoY6aK02Rin3OyWgQS3
 ZVnw7sGSgFP+ZJgnoVoYABy+M7hxA+XHE3vRY+XbwuHuT5e46I2nvnwoagVBIQKxFNP93AiN4+j
 +GfpL+Tp09oZrpUjwYX/rV8V/Na4NVufwTx9QU6f+2ZAH477FLD0O60ZK9tiTAMNcdNpWC5zVPA
 kBRlMPS32MId0nLdyUc3UDl11piQeHd4OsPOQ03lPydrZ9kQC98PYsGttWWODowVibmiaGlAVff
 Jrivq7N/M0ElFB1hH+BvM0Q01xs08thKuASNo929V/hv4Tx4HrGVf3eJiqO4JWyvTvoZA15WgBB
 bcvFm0+ecKmWF+1WrUbqrT+QDlpNbV+4xL+peR9dctKkO6jxw9+61wnWM+J8QbJ9ZEU/pdbKGDZ
 k3DG6r+/Jx1bHUvxnRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200051
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

On Fri, Mar 20, 2026 at 12:25:00AM -0400, Jonathan Marek wrote:
> On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Marek wrote:
> ...
> > > 
> > > That's not how it works. INTF (which feeds DSI) is after DSC compression.
> > > 
> > > INTF timings are always in RGB888 (24-bit) units. Ignoring widebus details,
> > > the INTF timing should match what is programmed on the DSI side (hdisplay,
> > > which is calculated as bytes per line / 3).
> > > 
> > > (fwiw, the current "timing->width = ..." calculation here blames to me, but
> > > what I wrote originally was just "timing->width = timing->width / 3" with a
> > > comment about being incomplete.)
> > > 
> > Okay. After reading the docs (sorry, it took a while).
> > 
> > - When widebus is not enabled, the transfer is always 24 bit of
> >    compressed data. Thus if it is not in play, pclk and timing->width
> >    should be scaled by source_pixel_depth / compression_ratio / 24. In
> >    case of the code it is 'drm_dsc_get_bpp_int(dsc) / 24'.
> > 
> >    For RGB101010 / 8bpp DSC this should result in the PCLK being lowered
> >    by the factor of 3 (= 24 / (30 / 3.75))
> > 
> > - When widebus is in play (MDSS 6.x+, DSI 2.4+), the transfer takes
> >    more than 24 bits. In this case the PCLK and timing->width should be
> >    scaled exactly by the DSC compression ratio, which is
> >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component).
> > 
> > So, this piece of code needs to be adjusted to check for the widebus
> > being enabled or not.
> > 
> 
> The widebus adjustment on the MDP/INTF side is already in
> dpu_hw_intf_setup_timing_engine: the "data width" is divided by 2 for 48-bit
> widebus instead of 24-bit. there shouldn't be any other adjustment
> (downstream doesn't have any other adjustment).
> 
> a relevant downstream comment: "In DATABUS-WIDEN mode, MDP always sends out
> 48-bit compressed data per pclk and on average, DSI consumes an amount of
> compressed data equivalent to the uncompressed pixel depth per pclk."
> 
> Based on that comment, this patch is correct, and the
> ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component)' adjustment only
> applies to DSI. (note: newer downstream looks like it would divide by 3.75
> here, which doesn't make sense. older downstream would divide by 3 here. I
> guess downstream is broken now and video mode + 10-bit dsc doesn't get
> tested?)

I guess, the downstream might be broken wrt. the widebus being enabled
or not.

> 
> on DSI side, "uncompressed pixel depth" shouldn't matter either: DSI only
> sees the compressed data. But based on that comment, when widebus is
> enabled, by setting DSI_VID_CFG0_DST_FORMAT(?) to 30bpp, then the DSI pclk
> is in 30-bit units instead of 24-bits. And with this series DSI side ends up
> with the right result if 30bpp format and widebus is enabled.

-- 
With best wishes
Dmitry
