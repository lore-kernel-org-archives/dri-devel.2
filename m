Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406B2C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFCA10E246;
	Fri, 10 Jul 2026 20:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ekx/Ir9K";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ub4xbvpp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 841A210E246
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 20:01:48 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH3hAo1443864
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 20:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6TauvJkutb2hiYeXYH72NLc7gaplt5eyXb6hMmwHelw=; b=ekx/Ir9KisQqT+sO
 S+dKYkRjkjB89OmCaMF97bUAQTE4ze415+U13BgRp71chl9J8OEjUDfECg6839Yc
 nrHU8OXQkaA3HRIHSAsV8zu4b9FSDGXSVoYE3+JqrgU63WAXQo7Y+LXc0Qn2dbNZ
 212MK8O2wSik+3XE3fyIz8kqOILZi9bFNmrGti4fH90kNAuOWbthXc1f5nzxXi3Z
 i3SUAjXVjvtmqxsJsvxaQjH7BE46ROkkYC942Ci3GUBi7ZxKgprf/NNh+C4N9Moi
 KcwsOwgJ4eWEKmHL0/2w+8WpmOwVO7wPVFc8npsdtlae8mdoAPVb52lzhb7gw2wn
 ZmWaaw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwec4vp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 20:01:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c6bbd0afffso23417385ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783713702; x=1784318502;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6TauvJkutb2hiYeXYH72NLc7gaplt5eyXb6hMmwHelw=;
 b=Ub4xbvppoLrTdFsu2rRPF1LBMtroIeVTjySVcaJ1A/lE3fMxy8YBf5qHrkxsNOL010
 jC0d5Dk6cYPjOXBKzJnS6qMSSOnvkdmnlDmTfuJ9WjR5u31ANplRx4j1T8yCBBDGglPM
 0TxAnZCB6j1P4dXbE3pt4+u46eEUu+D2FEjmqG1kFqL4/4Jv87KGIUUNrpUCocTBZRT3
 Yt6jCAizJe+p7REMxE/MiH5oOUGEOADaVo+PnWsFlNA/3H7n/5i4/sratp8Ht4lkxYMP
 pDji64h+CMiemgC5OzCq2IvbNK2FY3fESv0qyf8PBPi776XBEvE3boQ/MbNxcXJOd9A8
 9cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783713702; x=1784318502;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6TauvJkutb2hiYeXYH72NLc7gaplt5eyXb6hMmwHelw=;
 b=c90UFAyOJhgVTa0Sr+Vi93g1cHpLqnhvc02oT9Bij4V2a850H0uI6YGli8jfLCZ545
 V9129skM/cvOOKW2dkQxkHkRnZSxYyJzjXccpi8PjDKQeMBw3P+/ifJ8e44kIWrtF9mA
 X3AtevqhVikd9JNlFK3MO7/99u2FjSM3G6dLafeTgkAt83xIcHTBzkO2PxGImB3B8K5/
 h3Sa3p1U5j+0A2+efPR+gHgCw2+IBIsJyfZZIgoVeRu8ggSzLsgmh9EkA9n+vfH5VlW9
 MJq0SY8KFdjrfkEb1oMiVxDAcZK4aVOtWxSqyiYQmFAFCOxJU2lkkX/9isnKnZo6y7lI
 RAug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rql+1FYUtvgxEzVMHhmKh69q/KKEtsrYtSudmO5A/TRQbpEGD6U0Ox5/+2+Nr5FkUo5fdFgfXgaRjI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxU8kDQt4hop2wOaMqK6ocZCI/1ixBjFGdqbBJFBrV1zk41nzcp
 BWrGoOacyjAd43ZYuWpFGIHw2bO4c7J5t5z/iAWiFZ+Z8N395z1eFq9ESoVdIKSqfW9ST04tmiE
 h182nT46avEP4LFz3JVPnO6p4jUwvOBONKEVBlfT8aVwbu0p36IugSSy1w9BsU1rcG3dMPs0=
X-Gm-Gg: AfdE7cnI1TY37AbnK+TeJx5KZ93hadYqxRWAmjDyTC3UNcGdI71WpQCWjRTUIGv448Y
 xLvKIuU3p1ic83Z3Cgv036foF650md5Ng62tr1ey48aFTLWczcHe31wy9xymsS+r/V74SHy71k5
 tow+0VR1Zz+f9tUNb5LqdnDQYdDTratGOHB5wIPZIJ1a0mOqLiQ1f7v+vRNO8Eu0gmQzw2eQUEN
 OnP6pzMBuZ4qOjXSIz39pzbhf7PtIUTGVEcVdcARTGJq+qsSAlKGlSR5YdBRNYiFAtVD+lmUis/
 iVYo0GdlZZqG4RTHsdQkIyB9BazO5G3lm1wBp44fR/sqhybktKbI5c1VIeOV4HO612B37Z7pe1H
 gO/xsqFvHWY9C9lph8OZLTGKjjgXMVkB+CJmEbrkf5+k3N1biUq5uDxz9Ip3eitxV5IH8
X-Received: by 2002:a05:6a20:258e:b0:3c0:42c0:702e with SMTP id
 adf61e73a8af0-3c110ba2a31mr439274637.52.1783713702134; 
 Fri, 10 Jul 2026 13:01:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:258e:b0:3c0:42c0:702e with SMTP id
 adf61e73a8af0-3c110ba2a31mr439205637.52.1783713701649; 
 Fri, 10 Jul 2026 13:01:41 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659666e7sm50819545c88.7.2026.07.10.13.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 13:01:40 -0700 (PDT)
Message-ID: <3f399cac-d82d-4d52-8a52-45cd9a0e31d8@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 13:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v9 00/14] firmware: qcom: Add OP-TEE PAS service
 support
To: Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org,
 Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <178362521364.2422497.1305957434056184382.b4-ty@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <178362521364.2422497.1305957434056184382.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a514fab cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=G7o58nB-JDmhE5M--eMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIwMCBTYWx0ZWRfX8R2j4WrSt0JE
 JTQNGA3lvbK4bkUQfi0oYVYAYITxdnWowYKUf7JBZ95nq+OSu6f5H12ye16d9Ag60DLUBQ+T0K4
 eBGwQXDoFTV+BB47Oqy9NUvHqf02tyH27UTNMOB4Jkd3UPR2+n2Ig9ba6DFl6SwbYXpbhg3bQz/
 D/QRoIVXYTCzDYCs9z//R4/TbCUk0YWrdVoeHZvFsMKsb7rbD6rMF6f/dzLfdqiOXLFzfNbottG
 tegqVCG6K6h2VdPmBYP1pyWqhUEqLZIyR8WMPOdMGFW8/q3WdH9NF86h1f9T5sJksv2+hhKqmAc
 t8njNmZ+fQIRhFxGoIdePGbJLgxpiZwwauVyq4ygvakiEHzGwPUMz4wJv2wa/u5jMl6jeD9F014
 XHPDKkQGPzOxrDGUjeKpbovrovs9TbS8oFkJKTjoR0fHO+H3eByHI7UKUXXBALx9OSUgz/LZhaT
 CTblYsAWvTIf1Aszsow==
X-Proofpoint-ORIG-GUID: GhkVHnOHa_RFLYHkk_srlvNctIQ1cUmT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIwMCBTYWx0ZWRfX8xpq6TNoqFBZ
 6JqOgaSCmOx2O65VOtP0VqCH4xaiUCKnaR3GBGY6tjTdvnk9HQ0enVHFqsJnc5y4FdSev/7tD98
 fx2fKrencCtaYobQoGetn+o9HqfJitI=
X-Proofpoint-GUID: GhkVHnOHa_RFLYHkk_srlvNctIQ1cUmT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100200
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

On 7/9/2026 12:32 PM, Bjorn Andersson wrote:
> 
> On Thu, 02 Jul 2026 17:28:16 +0530, Sumit Garg wrote:
>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>
>> Qcom platforms has the legacy of using non-standard SCM calls
>> splintered over the various kernel drivers. These SCM calls aren't
>> compliant with the standard SMC calling conventions which is a
>> prerequisite to enable migration to the FF-A specifications from Arm.
>>
>> [...]
> 
> Applied, thanks!
> 
> [01/14] firmware: qcom: Add a generic PAS service
>         commit: 08314e7c2c38b9ae6a5e01c58ed10a950859404d
> [02/14] firmware: qcom_scm: Migrate to generic PAS service
>         commit: 5c1a2975d23c51c01aca51945d0f10a4ee4c9020
> [03/14] firmware: qcom: Add a PAS TEE service
>         commit: b6f7978da0c4d26fe465aa6634f5a0b48f900de0
> [14/14] MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
>         commit: 6701259025d49139131a0eb2257659a066dcca22
> 
> This is available as an immutable branch, for other subsystems to pull at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702115835.167602-2-sumit.garg@kernel.org

I've merged this branch into ath/ath-next so it is available for ongoing
ath12k support.

/jeff
