Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CFFCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A302E10F052;
	Mon, 12 Oct 2026 12:24:59 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 682D110F052
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:24:48 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0biq2679927
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GJT/DkiIpi+sKlIcqZxCDbCI
 /Dpo/QRPmr7TBBKi1E8=; b=C/3W2iUOkR2KCADsqS/uhtOy8u4bS5D0ffQCMWHb
 uUch9DZW/R9u2TKkBKf95zq3R8DbXA2NSSTTHmz/DKnWb9Dcp5Nym25rgVi+c1s1
 EgZ5/U8VWpc0biuiG7rBPd7fgiR57Bj10sdsVXRe9c2Z7B1QoxvcmxiPMeIMEFlR
 ynPMx+L2a94kcISVeIPsGonCnW0OQh8DQ5LHBnTQr5JT4DhlXjUqpREFAF3djC1c
 iJ9Sxj551YfMtbGKjbWjxnBEP7vfMMaNBFo7xtyI12ieJSJq/x2VPNkchu3T9nW1
 U4hMF7As0zR1+NTi7UQKeK/zHpjPAfwR/XX4iEHscb1gqA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1svxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:24:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934956beec8so356935785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791807886; x=1792412686;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GJT/DkiIpi+sKlIcqZxCDbCI/Dpo/QRPmr7TBBKi1E8=;
 b=ivoLzyEChLEuSWphFIsUrUdAwdfm+ydYjl4CCwycJOO/T6FYaGye4z/y0o4/c1Uv+S
 WodiUC5SMsTjmNONajPxJWKsyUeEb2w3unRfQ/xRt0CCZL6nNocvd0SD27sHZAO1A4NL
 fKKCrMGEzZmaa4G2KFcbtHdGvNKChfgEe6mizm0Hz5kPpsfnt9HF+jpFccNQ3RZqAnLE
 dFQdRMk2iNpOWXJv+77NQpwfiJa5KO4zrAXxo76PovW2pFuzaCUdUFQDJjlLZZJvs+bJ
 jyHO2ZdrlWjTGL8S1dn2d5LNIXAXt6N3OCMIZWRYFpBZ1Nbjv9E33KMH0JdnA4WVMRkV
 ZydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791807886; x=1792412686;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GJT/DkiIpi+sKlIcqZxCDbCI/Dpo/QRPmr7TBBKi1E8=;
 b=LeWSN7S1FrfiQo+lDK2zaetvrnfhhGPO80XoS+jlyWQ0FtsNw/rzGmVrxGII+aGQF7
 49ZvrIDk8EsM2eSV4SdwsPE2mvFFxcS8caow/DNHib//Z1TCx3VmJtTQqiOjkn36Fbe8
 d0e2PN+jIFMjqPY03h28cX9FJEKj4EbFjAYDe2kau90hAnic4baPyAii9qWS+kgK+WMn
 y59W8je97W2o9Cwt5/auBSIVyp8tFG1Iua94XfhvITGGnVsfqfULtR+8vpJ2vH+oIbro
 6nS9/Ub3Kdy4PNjpePDvgbqwdlJVkWCkZmpVGE80DlfDCy++SDmMddUrsjG5fkVCwqss
 AT+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiLOCSL5DCutn+XXHIhnFFkWdiou/9Fbapq1bUv6wxooswUiPZ0JwH9WOj/qwGe67ilOsTrryyx4Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ4VwS3oJ/8SPsLIRqsltgV03Ystmak/ZVICEnwtTIKIQmuxDFl
 74+JwERdLlQE2lxcP9zxPek4+jkqlQyIUBW1nJJtcj+4Uhj9dUlQhX2AUs/UMmnf4hhVVVAZMIg
 YR36D4YWxUE33ZL+aNDG0+oinnRwSeM0d9ljZS2ZSlaUK47VEax6fS3U2DmMH+QyZK0Z2yCuADS
 eLKjM=
X-Gm-Gg: AYBFou1FCkInfG37dUSqZpSkNW2ZnRgDirE3XU03es8cBx3X3Gj7M3lNdbENUHdZznv
 GoAZtEZkitoB7qP98kax8M4GxaUNV6NuQ7sCsJQFyvLnfN0WQbHuK2ASkXS127dKcPiAsFBjWnT
 GnL9SCcUuMLqj0TZHJbZocA6E8DLYD+iuGJF9fpYH8LNBiKHuM3YvfHv60ePcU8zGM1VEemmCny
 pzkD3xS3ObcgJvAJEzdCk22Ud4HOGLHDx0bu20E/n5gMV0+SyQ8KdOiA5k8ACk3+OMtCKoKCI0j
 LzwbJG/SK+z1QN3TNuQwGpmJ+eylMupsPfHL1smAGJ11AfbyvOb4Zpl8YBYjymfiw4dNQrRfwFQ
 HW9o8nKGYslS4s73dI6Zh43w9TslYhIHRAyPtsCaNjftB8ZftRBjA0GVtnxVmrnixF7219mV0fz
 /mIIX7PCTNg3fy
X-Received: by 2002:a05:620a:a0c1:10b0:93e:c12c:4415 with SMTP id
 af79cd13be357-93ec12c4ac9mr1057654885a.81.1791807886433; 
 Mon, 12 Oct 2026 05:24:46 -0700 (PDT)
X-Received: by 2002:a05:620a:a0c1:10b0:93e:c12c:4415 with SMTP id
 af79cd13be357-93ec12c4ac9mr1057652985a.81.1791807885921; 
 Mon, 12 Oct 2026 05:24:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9dcdf4545sm13169001fa.25.2026.10.12.05.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:24:44 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:24:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 12/35] drm/msm/dp: add support for sending VCPF
 packets in DP controller
Message-ID: <rd73b5ovrmqlanussaj5cugi4fx5yzuvwam2kzcizdiusmxzib@ko5xasxrjrzx>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-12-4b81473185e7@oss.qualcomm.com>
 <20260929045000.55AE01F000FF@smtp.kernel.org>
 <t3klzrnzq3oicg6djkv6ixwy6oteo6c6zvnpddbqk5pjhsodoh@qz7pcou23no7>
 <f7e864e9-8500-430c-8f02-915a162bd2a2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e864e9-8500-430c-8f02-915a162bd2a2@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: niN_iqCFNOI8aT5MWhyvIo4q7hwkgV4U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX8qgcpvWx5jVp
 BCl57HYDaZ4+JgBxiwg44Ama0mBxRx2gR+gPRwUhFhGz0y1/oqqvxUP3jOpmXF1MO87KnWOrNCg
 gqazWTr+VNA/l5/RZZoCqigTWgj3Uys=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6accd18f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=eQdJkE7PAM9i5_T_09wA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: niN_iqCFNOI8aT5MWhyvIo4q7hwkgV4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX+EkBrQaoOC/H
 t+Unj2SH7Vy+390hSpRwbAmB6f0yHof1ZopvtqHCS+ZXTxykAcZ9YgNSrO4AtWJUggp/bG641JZ
 0Z10IOiVnSBIcUilnWko6LFKhyNzEhLzr7keFJIRojfKHTefcxsaFkGX2RC6xh1/ajWhdOeQDce
 Mo9yhFU5Exo4Los/ceWRNC0o3/XnuFPJaFsMcaevExMpUC6xb9EF6xfg9EAEqCYHmqx+i2Jn9kc
 MUZwns+mgpsCbEnNZlIiG6DZFvnR85RgEc3XfBAAlaIGikboOs9/YAZtvqtViRZg8RpPj1wEcO8
 aVDvzbIA2eVSXOnE/OMii/PhOSbBVgIJEordX+3yhFimdS1aC/1pDSYm7Umeqf0zubi4sYj/5qM
 Q3eIG5r4+B33GClZ+/vbdq+kfDiD/rROYNNZkAHU9tXZnG4vMDdy6CkcD2qHWTLYbQpx2r8JG8B
 4bFnsT60TTjrIbPaO0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120049
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

On Mon, Oct 12, 2026 at 05:08:53PM +0800, Yongxing Mou wrote:
> 
> 
> On 10/1/2026 6:34 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 29, 2026 at 04:49:59AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Medium] drm/msm/dp: bitwise OR of STATUS5 and STATUS7 without masking in ISR
> > > --
> > > 
> > > commit 987123505b6cfcc4664c72feae6b070ad91b79a8
> > > Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > drm/msm/dp: add support for sending VCPF packets in DP controller
> > > 
> > > This commit adds support for sending VC Payload Fill (VCPF) sequences in the
> > > MSM DP controller when stream symbols are absent. It introduces interrupt
> > > handling for streams 0-3 using the STATUS5 and STATUS7 registers to signal
> > > VCPF completion.
> > > 
> > > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > index 9a0c9737e6d00..929e0f94f8ddb 100644
> > > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > 
> > > [ ... ]
> > > 
> > > > @@ -2801,6 +2877,16 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
> > > >   		ret = IRQ_HANDLED;
> > > >   	}
> > > > +	isr = msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(ctrl);
> > > > +	if (ctrl->num_pixel_clks > DP_STREAM_2)
> > > > +		isr |= msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(ctrl);
> > > > +
> > > > +	if (isr & (DP_INTR_MST_DP0_VCPF_SENT | DP_INTR_MST_DP1_VCPF_SENT |
> > > > +		   DP_INTR_MST_DP2_VCPF_SENT | DP_INTR_MST_DP3_VCPF_SENT)) {
> > > 
> > > [Severity: Medium]
> > > Does this bitwise OR of two different status registers cause false positives?
> > > 
> > > The msm_dp_ctrl_get_mst_vcpf_interrupt_*() functions return the unmasked
> > > register values. Since the values from REG_DP_INTR_STATUS5 and
> > > REG_DP_INTR_STATUS7 are ORed together here, bits from one register could
> > > overlap with the VCPF bits checked for the other.
> > > 
> > > For example, if an unrelated interrupt sets bit 18 in REG_DP_INTR_STATUS5,
> > > and it gets ORed into `isr`, the condition will see bit 18 set and assume
> > > it's DP_INTR_MST_DP2_VCPF_SENT (which is bit 18 of REG_DP_INTR_STATUS7).
> > > 
> > > This could cause a spurious completion of ctrl->idle_comp during a VCPF push,
> > > allowing the driver to proceed while the hardware is still executing the
> > > pattern.
> > > 
> > > Should the return values of msm_dp_ctrl_get_mst_vcpf_interrupt_*() be masked
> > > against their respective VCPF bits before returning, or should they be checked
> > > independently instead of ORing them together?
> > 
> > Please respond to this comment.
> > 
>  Thanks for pointing this out. The issue is valid, and we will fix it in the
> next revision. >>

Please respond to other Sashiko comments too. You got a review. It's a
nice practice to respond to them (unless you agree to all of them and
are going to fix all of the findings in the next revision).

-- 
With best wishes
Dmitry
