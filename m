Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F0BCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD5110F8B8;
	Fri,  2 Oct 2026 15:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4gH63PO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CgqmunYC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0E710F8C4
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:19:19 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGuNX2280287
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iTvqaXm6thAjWsyiqz/byX2RhQLAIVV7jI/yvKU7Pb4=; b=U4gH63POZ7Aqym9Z
 AZARVi7xa5QmOd8kYop+OgOa7pk44fMrw4T8EJxgoH3kEz2g573puHo0/zc5QKdf
 rLsklGSzdJyRD/3gUlUw7f/jJqJ90fz8WecWgWJosLKRLCZigHLzco9vlrimmRCy
 9UU+ZkrbfiSqJxvKCFA3aVAMb9BV7kVZ5igL0NSN8GihEdCW9gBEeHKm4V6DhE0N
 edaPtDT5s9AxR8tBjbJtOw+EvKqaJuF8LjQl0YsurBIBA+kOumA5KZJNVJJCXBcy
 ep/6zawOP2zEuLbboNH1j7fCYiNNJiThN2Jf8GhQUgedKYZ2p2eLO5kDLkIlMeyd
 rwnW6w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj011ww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:19:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2dfb24dfedfso55299375ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954357; x=1791559157;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iTvqaXm6thAjWsyiqz/byX2RhQLAIVV7jI/yvKU7Pb4=;
 b=CgqmunYCEizLwHElJmTc4kfZbAzEu2l8MpBg+0/LBRv3K0S17Opmu96Lak3QItJnH/
 L6JXkkl8u4zixIBNQVCz13WdHAcbQG1QElOExzxA9W8n1G7xAzeDznB1+1nD5TqHina0
 UTFnfSNOTnJMWOlaqDyFjIktlYPJM4vArEC/tgRlg2rQ+reldTAGrbV6XBwIeViPNXtq
 8cCl15vSpCtk3BYQp0dZDkUot/olG9cB9iXwEAgK3mMvcxd5UlLsMIp7JTG5IrRNdeym
 7UJfBnDGnlEcH+70czyNHlxRPbT6O3X1CovVpfzhWGxSjX/cJGbanMepLA9DbdX2gcaj
 MOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954357; x=1791559157;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iTvqaXm6thAjWsyiqz/byX2RhQLAIVV7jI/yvKU7Pb4=;
 b=tm78Suli0SAD4WMDxUXOq5GCx2vweIw4ZOJuOyeJ5X2e0JtLY++l6vgkjTPY4sXl2g
 KPWZ+9RuW5JHtEhJuw+i8GOoBgWpRPfCuqXtUMfPxejw1314mhbwWdKqKzrESMH63dXq
 frTYMD4HLmOLSMqku6j+w6vQfRY1KNtK/MWba5jnU21zNqZmKix5yoIBru4BsSC8CyiK
 qZaXUlLSgE4HqBIN3fLPu3OZlDbgaTnCdsRzF7IwNBHDMWSb+RtDpZuhltnRMw59UBQY
 KFwPjcE2xHHbqsYMv+21zll2cRpkmNDIfVinT3FeqRwgmumPBUK+K8yg3nLdMinVRKM3
 WkuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByC76aeqeJna2RgvRszS9tK7wRMN3xZ568lTHLAPtlJyjE0EZiX93wVvihAQslN2WTcweYkHMo/d2c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI0lIcp8SMT4XU+h3OjURmN+odcKF72UqoDXOMWo1uemqZz78yI
 XIZ/H8kIvRVOxah2+HJYBiRG3mZnBrCXsHTpGma9/jEWgFa5xRyzw3/ZUbvR+uK6E19/K6gjajF
 PBZzR8lDS9Pd0FZc+qYhJRonIRkOzoIG2fkDwMDErBbjwa224p6iC/DgCZb69x8oFsuRJo56CV7
 imJ2s=
X-Gm-Gg: AYBFou0rHPO2kuNfK3nLCVPPb1hCPK2SEJXQtBf06qSvZIdD6ljNqiNq2m3j0Y0Uhy9
 xZAUIiXT2C0kCyP1wbKyhCw2Sgc12H79sTUac8NzWblQYh3dXBZ1ZS8Hq/RTridMsloCbHTEMb7
 6kZu71amFgibZMZnAd94Hppy5lNUv12GKUva5a6yv9CmaHan4o5J08ddJTQA95a5qk1plaUM/pN
 KiDxASNpTb+1uIWgjeWPoXJaei5LFMOO31HAgwmANr8Z/Ui7+y/cVowLZ+gffUKZ4QL/tnEjBLl
 O60hQZHNJ8D/gtzi36RYcmq5I/h/45iQq/pyf4Po7pt7WEwNB1yO8tc64cbZxK5TChU7GzaXPef
 TaTPvx4JUuEHaoI/TpDVQIBxbxLB9l0FhWGq72inV27F7wbzvpA==
X-Received: by 2002:a17:902:cec4:b0:2dd:c100:4b76 with SMTP id
 d9443c01a7336-2e49b6ad58cmr27695455ad.45.1790954357260; 
 Fri, 02 Oct 2026 08:19:17 -0700 (PDT)
X-Received: by 2002:a17:902:cec4:b0:2dd:c100:4b76 with SMTP id
 d9443c01a7336-2e49b6ad58cmr27695205ad.45.1790954356800; 
 Fri, 02 Oct 2026 08:19:16 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49e1f20e3sm9508505ad.5.2026.10.02.08.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 08:19:16 -0700 (PDT)
Message-ID: <49f545fc-58d0-4b5f-8c26-69876969df4d@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 09:19:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] accel/ivpu: Improve HW IP gen and buttress version
 checks
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 andrzej.kacprowski@linux.intel.com
References: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
 <20261001110401.2866557-2-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261001110401.2866557-2-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX2NR86hAUZdvn
 dvb627bl8yI3dpeMVcnIiZQLmBiQjOPhjfuzwn/7EdCJNoOhkb1NG+kaP5AtPFBpD04zFiIT3y5
 yupmyfRN+67R8O3AQPlW9MSGZrhAA0w=
X-Proofpoint-GUID: 2HRIi_XbThvYI0-M1dCwjc4Vq_ekB8EW
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6abfcb76 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=zM9lGHBhOgGx5SmLCZoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX1vp98MInz0Ue
 Hh1qtrxr9t9f7Xr2IqYg1vBvc2BlN5YwUBu4e2gCs7KBm+J4VEvdx+Xgn1zhVNCwLSOs588TYmb
 xcIlHa9qysKWv/1GtpRvi4+Ivy4O9kDlCRMwaOQoHMGfNzsVQuLhi03nK+IM48shS3XxzkxTCPI
 f4vqVBevAISBlG/IOzSkGsWvLrGWG/IcctCJcY241ZQhrjCfTS72Vkl7Gc4CNjuqAPKzcWY3leY
 l3U7ISRhfe1zRWD4RN5hXKKBChPVm8K0M75TA5/lHqxk+bwqOnl/1D/aPAAvbc5+BU9qtHZnkqt
 wfpxFTUdQj9CTqDb1nBaV0pZOeNnHW+S8H76hg4SptaN4V5YbTfwzgcIcpRhRH3tH+RI/K01UAq
 UmY9r0KMcoLScKdJZuqyNb6IwnqIaL/MgeboouwSvWTik8xjk6cOokgJmr5TXMPGZuudRR9OOex
 IzcITWFk9FpEEw9xVMA==
X-Proofpoint-ORIG-GUID: 2HRIi_XbThvYI0-M1dCwjc4Vq_ekB8EW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020061
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

On 10/1/2026 5:03 AM, Dawid Osuchowski wrote:
> From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Remove the per-call switch in ivpu_hw_ip_gen()/ivpu_hw_btrs_gen() and
> instead initialize the HW IP generation and buttress version once during
> device init.
> 
> Fail probe with -EINVAL when the PCI device ID does not match any known
> generation, instead of warning and continuing with both fields left at 0,
> so callers never proceed with an unrecognized generation.
> 
> Drop hw->dma_bits and compute it locally to remove the early dependency
> on vdev->hw_ip_gen.
> 
> Make pwr_island_delay_set() use ivpu_hw_ip_gen() instead of the PCI
> device ID directly.
> 
> Move MODULE_DEVICE_TABLE() to the top of the file to colocate it with
> the HW IP and buttress detection logic.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
