Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D218105F791
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D54610EB7C;
	Fri, 13 Mar 2026 10:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7pWufAA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fs8KCTXZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38C310EB7C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:28:31 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D9U3hR1499525
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fyC8EkpBaiEoOs4Wwbk5hxiQqHnnTfsVCZLncu5TuYA=; b=R7pWufAAjfaSwdQ9
 tX6Kmf2tX7wGCUXeDV6OdFi5HVQ27IDpyhFAMTG/vveIfv/ErfsjUKZUC+PXYSv6
 WLVL0lDvRh3JHKzQTOQkNfG/gg23j31OuTl3InKt31/lMsB0gztuh3c+cTksL50v
 1PioZEh5YBo4H/rJ0+vMOidvIGsvpOYaSf/Azp3VplEg5RORqIXQnOqqqQnEbk4w
 fAE6iQ7614cLN+34WZVHuerUCeHJHOX0fwfctgb+9bBCQ56kzKcLL9StptI63ygN
 WcgiUZOLyy7CX6oZuJrWaExwEQ/D7ohF2La8YwEyaKjHSZXWeklPp16HlRtzvae2
 aaggIw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvg0hg6hb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:28:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cb39de5c54so110874985a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773397710; x=1774002510;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fyC8EkpBaiEoOs4Wwbk5hxiQqHnnTfsVCZLncu5TuYA=;
 b=Fs8KCTXZMXxwOxzCuV32uUq2vDryU5hHlCbByfUAExrqcIUN71g3K06bNx40WJnq02
 IFtPHVJ9AD1oO8L/AYHNq2eNveBBdl1Pj5KVHAH7X1LsVknD+rf4s/23jXWNUyf+UNRp
 YJDE0O8Hwfyrhs7Kx3WuvgcnXM0s3C2gF8FOrox51v7askqyLeOSGpfInTFMGFPjTU55
 4sE0LMCSR42vrZQHG4R5RR89hyPapvOMmGT26pgqoKeyG/U+XvdwG3rm+1iKOSL1KOl4
 cWQBTyYkWEsbRp/pqc0f5szS+lKyqKjEmE75AK+slYX5T3zDlusk8RCOiEKhaCzNfZbF
 TzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773397710; x=1774002510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyC8EkpBaiEoOs4Wwbk5hxiQqHnnTfsVCZLncu5TuYA=;
 b=D/sr4G+gN9f6xVd+FhQ9RQ0g31hG2sG1LCEotH8FLh2MfDSKHfs2AUR+uXTjIOnx8D
 Pu2vWAceK0exta8TATGN17GuC2rn2uo5zWLl39sePpKdyFhF5EsTI0EcDBmGXevuVR2R
 wWKjYG9Mxu0XF2/fhwJDzX5dvWV1aiPdpaphdYGAv0HyGVBB3PVAvtpEXvDBuvKHNTV6
 Pn0kZxbbtiFggjx2mSgR+T3QmXR1wyO4EgfA7JVn4uU3/Rx7f+EY1b53ku6IOJiSg4+t
 ofvWZbMwrikng4mvKRjXLC3Fnoa0JXh1ikPgvqVf0qygv4U7OLhOlJimfIBtHW9ssGLn
 dnZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc9yeU+Re5PsICZU2kfh0qkaSwlCjxZGpYq/xdorIEGgJDn3uuQMmZv+6yJ3cTLfXzDIFBJgTThic=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAG3a7upyk15q5e1r31xUkRAvfOYXFzCI0RbgyXxtmuDd7QocP
 A5aRGBalko66jzU2l0mOnvHVfEnUAbgWdw8OtbSRz42XccpI2DR1TI/VO+RnAQmyMYlI2jqLonS
 ovNHFwKbbwJY7gIB9oaLukRNNuJjO/MZ0mpgvgLd1I8g6WNa6V5HdGQuUmTudId+0DwXQLKE=
X-Gm-Gg: ATEYQzzE00zsOO+a8+QhECiP8aa8yyuLrpSUQFR/TqFBxFIusTwcQabZDftZOumfUgT
 1PAPOfL4Zy7tGwDrFAZoxT55IRiclMKhfTWrD8VERprEbH5z/cQcGPfWXt+phZPCoX1BTFwV6Rx
 spJdPJnAim61dfbluYCST1fJDoPZbAwl330B2v1n853oK1wGLioiVom668DEx/EmsC0iWpG6xXt
 J6Yl2Se59ZuT/MOsH3jgs2B69Er9J1NKS29PYxJqVocPO/Y5nFPB5c6l6qKPWNIV1D5j5rYe8VX
 MMZqs7u6j9A9KqUsvKgxwDoUt6i0+sTPQVe4yR7+tXoa4adGwn3gXag63tIsz+57r4FRt68Du5O
 2MpYjnOPkVxcUIpqBmvBzhXPYhaM13Frme2jTPYTAODlBJtCLJeHRg8tGz2Nuqh+ybupqJfd+LX
 CyCwE=
X-Received: by 2002:a05:620a:4629:b0:8cd:76fa:1bf5 with SMTP id
 af79cd13be357-8cdb5b97c2fmr280630285a.8.1773397710438; 
 Fri, 13 Mar 2026 03:28:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4629:b0:8cd:76fa:1bf5 with SMTP id
 af79cd13be357-8cdb5b97c2fmr280627685a.8.1773397710071; 
 Fri, 13 Mar 2026 03:28:30 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976d0c745asm35589566b.67.2026.03.13.03.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 03:28:29 -0700 (PDT)
Message-ID: <52bd0410-5009-45c8-bfdc-b493e2f60610@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 11:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/27] soc: qcom: ubwc: drop macrotile_mode from the
 database
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-24-b7e8f800176a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260312-ubwc-rework-v3-24-b7e8f800176a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69b3e6cf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=I54dV6YZZfg9ki0ab94A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Xwi1wCsqrO4scmTK5nIVa3MtESq6dim1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MiBTYWx0ZWRfX99elQLU1/FMe
 v9S6CKVvMuNX5JQ13Oc7Q85ZZgAjDtTO6DSTwLo8jGy0Sna1SJ5Rao6YqxLZsytFkYEOYHNxdD+
 wL2dt33ibIQr9cj/upgoOyLmIOnuA+HGTc9N0Fn7pS68MYB23eyoCGVrSfeUy8HLYgQh/5t7LOA
 H3262D50J2JK1OgEbKdj20k70TfU1R7ClbzKVB69/g818F/dyoyuMWCQPUJ92v6B1XHZdegqvjJ
 CKHq0nbMMO46YTclwq6ezhErJFp+6qMpwoaWIyNkUG4KYpccztIbiwXFbfBGL2hG/dX4TH1GK6X
 96h43Kxew8a1OoyjPhLr4eNij6XmIssOMwDkL6ibDSOTuFmPsgq80xSLEZXg72yP1RhZrIso3Na
 8CT3V/HtXANaz1QpENODzwARvazDwDIcJZXitlylNemZjF+zGGmSW0LiMHqksoh7Vr70Qm7V/Lr
 5TK4r4RCAb9f6ytWtfQ==
X-Proofpoint-GUID: Xwi1wCsqrO4scmTK5nIVa3MtESq6dim1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130082
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

On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> All the users have been migrated to using qcom_ubwc_macrotile_mode()
> instead of reading the raw value from the config structure. Drop the
> field from struct qcom_ubwc_cfg_data and replace it with the calculated
> value. Split single UBWC_3_0 into UBWC_3_0 (no macrotile mode) and
> UBWC_3_1 (with macrotile mode).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

>  static const struct qcom_ubwc_cfg_data sar2130p_data = {
> -	.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */

Is it referring to the values reported by MDSS (4.0.2 enc, 4.3.1
dec)? FWIW the other doc only mentions UBWC3 for the platform..

Konrad
