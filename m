Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD86BC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99BD8910E;
	Mon,  6 Jul 2026 08:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SaqEcrQZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmLLhVZj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BA910E833
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:49:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66683sov4156710
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 08:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oDj+GWBjiBSeF5JpgYDOTVoWkRnCXYhtIDJ7JnjDj8U=; b=SaqEcrQZixh8kqJX
 NIbjiiJv30noknviAqvmMqgcd9dLg97+KHUy1B+DowDAtFZdbHov2MJOyoJff6iq
 rqDYW2t4byAMNskkfn2DEmteAKvkbmtwdfnzzGWPM9pYwk9ipzRkB/unQDpp8wQO
 spC9sxDTJrVufwRQlROqiocRM89e1lPBV1O8a+WO5Ti9EHzSmsRDEWPLvWF6owNB
 KQMo662zF2+8K0WTRQ81OMSHEK20fKVNoKuj+ARZc+lVli3a93Wr8++tSyhr4abz
 mQhBlKRhfEKrta7A91FCOx0fOf8vmN+8cT/qCJhPL0qbIjn1JKUVPpUrlbkgGQV5
 z0EtTA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h986dm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 08:49:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f3951a6d76so7424986d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783327755; x=1783932555;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oDj+GWBjiBSeF5JpgYDOTVoWkRnCXYhtIDJ7JnjDj8U=;
 b=ZmLLhVZjwQRDsv7Mnawwd+/KNXkAo67tndSqklD+UuT2QaycFbnxeeUW0nZ5f0Byup
 9gXkTqqzuoeeYQ8LMNkERDSXXSUGA2J7N7KlU0/mmyn1i1KyUVDrlrmDN+OfLCyz3TzT
 04YeMC9nTRqHkmroexI2mZL9ZbalGW5DXIMkdlL3pxsSoCX/B/CAryDhMPfqGhNEXwwV
 7YWC7gBYoO9dCEv8QK8QtQbX6CwUvmx8Cw0S73ho2Da0HLYRpHJOKSztdkC55iWe2+o/
 HE+unkZ1ky6OgTCb2q1RhaCVqVxufzibZ8ohGvCphDo3JrRA/x0OEBzNP+sWQVDobIQ8
 aK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783327755; x=1783932555;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oDj+GWBjiBSeF5JpgYDOTVoWkRnCXYhtIDJ7JnjDj8U=;
 b=j8h0eFc/cEMI/mAs2AGa0Qs6E+Jd+DaaGMCoihOWT4JrMyz0ZDcStmfc2FFs95fbWO
 WD/XzftwTR04maYWM/GxcuJz9wYb/0JgoNutB285mBkFOAkoYBReX+Sp0xxNKIrLSVsp
 nDS8UyAX/5UcE9VeLL3stNOVeZjoAXsH/LqcyeV+NKTOjHBe33s2vgFjT8dDBjV2EXGq
 s+n5KJW6hIEECJAsUkJPU3PPnlhhPmtalNvysLVRWsreT3il5UrFsLyktjC3yEMApeie
 +vWasHrSk2hNfAU8OT3XQqTX/OFksQzPFvQFMVVBY6Y55reuaFKZDSndcAU/my17vTMw
 iNaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoI1Zrbqbfdt+jxEMAKBViSmAkeae6BOoNP9jxOuI8R6qIzzVXOVVnE2zMa+0rASM8mbWO+ZgpsPJk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzaz+1O5CvdJHUeE/upb5zYbffFu06RsdM6158YKMO+eCFVYOk7
 hhbyt+1o1WfIR1++ihWmnV+PotORbUbjQZyvxz/Pko6IxbIjAJTRdi6pubpIJ4+iJd9UpObkLjT
 KyAp7XX8qgrRLVAB78U4OozrePjUPbbid15CXKVvP5u/dNaFowQ3Sv5tmUYPnjpqbMuy4Dqk=
X-Gm-Gg: AfdE7cmcDdPKMhosh3nlT6k0OF5GZ2/Hg/LCS0xVWm+4HFN8669Sr8TTxOQmj2R/c8k
 8w7yboZ3ExZzrvbu3uev51INTnjq+aJx6+QgayXhSQSUR+lvVeT+UrpVhd2KOgDWZIJYa2h/Tiy
 qiVk/lVlLo4X3N32Sg7UZdIFEa4Ozmzx39Mp6zX7kjMCUUBYwZ5iFiBwWQK2v5G+TzYntolSWHQ
 QI6rJrcGUeQecvOuxnd4mRMnIs7Yj71FJfwYTm8MtQcoTr6VsPfiUoJ+v6Ym0UZSe5cSFUtNh6j
 mDlglZtxNgN5O9cHCO/lM9pv0G5dHLUHCvJFW47pkjPhWQaaqHYlD03Ins138mzFtHO6vB0nW+A
 RJNzkK/Ft8oDUqW/ssBIrJg5cLS7oTF6SFhw=
X-Received: by 2002:a05:6214:5181:b0:8f1:7139:d6a8 with SMTP id
 6a1803df08f44-8f749a7315fmr109104096d6.2.1783327755094; 
 Mon, 06 Jul 2026 01:49:15 -0700 (PDT)
X-Received: by 2002:a05:6214:5181:b0:8f1:7139:d6a8 with SMTP id
 6a1803df08f44-8f749a7315fmr109103826d6.2.1783327754703; 
 Mon, 06 Jul 2026 01:49:14 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cd88aesm3455501a12.3.2026.07.06.01.49.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:49:13 -0700 (PDT)
Message-ID: <a4f31004-8e74-447b-988a-e3250859e74a@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX-
 variant register
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-2-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-2-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fI5-4xiNx2R8wbKihbmEv7pDPy1Z3ylt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX7hPqhxsiPeX+
 X2l3vxQ/chHkUFzFPEfgSMKO2BKfKxF/4KRt/hn+XBOBauQd+cJu1IlXXKaq/D4+tWn2FNWgiDm
 670+px3UPd/cOhKzkrFz81nXd+r1Uqc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX2iFQ/srqFgdT
 iIphXAJK92qqNcZ9FLv4r4bX/PcmVxoFiSkk0OZLTmbYkvjmgN78/QS4CLp+TOUqAUz7AS5syR8
 OpscSq1ALCjTUesnlIK478cIwPUaUqZf5MS3peBpu/Hy9AXpPFcyzrK+ZI7K/cOXu8WiPOht8g2
 whHLlGAmqdXVALE6Bf1bAGaeoJiHGhzKz6zKmrZjcmeCaRFrKLrO0tjDfxEguAlVCFDmcRMzlxr
 RbltUE6EyIcDb4JkUtkp/SEUiKIu5fg6mppL/luYWyT4ubABz0kKly76Fn4IizHx57Q1atfw/uh
 HYBiNQ3+N3/R7nQLPtcgC2DJ+issJbXs5P2uWoEGhSueLaUA9PZIaJHT77bDok7HLkpDM4RgNbK
 /7yTQbqWC7wmUtGa+cErauRe7ovfl58gfQRDlyO0GhlvhHruN5Haj1Kxu0NZVE+TuHoMWL+Q2+b
 QK6GEQjxi4CM6Gf0iPw==
X-Proofpoint-GUID: fI5-4xiNx2R8wbKihbmEv7pDPy1Z3ylt
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b6c0b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=m8Bw7PwqJOGBpySAz2gA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088
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

On 7/5/26 10:14 AM, Akhil P Oommen wrote:
> The GBIF_CX_CONFIG register exists on GPUs prior to A8XX (it is used on
> A722, for example), so it should be tagged as an A6XX variant to match
> the register spec. Widen its variant range from "A8XX-" to "A6XX-" in the
> register XML and rename the generated macro accordingly at all existing
> usage sites.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
