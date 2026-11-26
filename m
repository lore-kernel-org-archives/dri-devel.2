Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CBF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bFGxra/0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h8fMA7h4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C5A10E9FF;
	Thu, 26 Nov 2026 18:33:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABFF10E9FF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:32:51 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQGbxIP595616
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /AAbzqN6gL/Sx0YtNRBarMK5mPpXPZmH0nkOki+mzQo=; b=bFGxra/0eJHHWFJu
 0RIQ9y64G1jGfSfrswDn599e6gfUxhCB1vdVAqNwN+hTh0vSvGkAaHMQQemA3pnM
 2wMvlAYeqZO2Zm5ySUZkX6XKS+EkyvgALeb7EL/coJsPdVcHiK7WoYefnVhsNAti
 ZTOODe2FapSksKkYbyhcyTF0EYNMBqGni95LkfE7w+lSL1hkntzTYnDLC/RsTYVd
 A8pZCc4N+hYZXxgatrUZlc1eZNQgY5fabHEqmHEDiGIvYZDBtUtEUVRATniJE3is
 G3A7Lk+qZ+WpZZXbnwYFC5s41V2Zd5yk0NTFaF9BWG7/RZWqGjtT5N5alG/W5+xF
 jojcpQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf90bpd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:32:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so8205080eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 10:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795717969; x=1796322769;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/AAbzqN6gL/Sx0YtNRBarMK5mPpXPZmH0nkOki+mzQo=;
 b=h8fMA7h4KHuuSeJmQjR7Ie1j72D8AduSkZvDA7SLhEI9P9RzXtV7ioH4XmlpNYBiR2
 e/21HKUexPQNFgHQzUUVJcbBAKePhuwmK3fvYQAPkd/ZJFRk2PyHDrhAuQ4qFKdahq4N
 f830uQZse8o8xoERMi/6ZF+A9bYROb2/cRGozuXyZAnKhD0IWN1xSiXRsxEI/WknpmN+
 JKNnamgFw5EZb2Dk1pDqc+VymQgNenNNNOorp11H7hg/DyBiSopKumAqWjEvEOaXSTaM
 fSvhK1ntaFlULdgYrQG9ptE/xRIAOpMT+nDby19zHJhcXxzypxs0CL0fTLmHk96AJ9PJ
 sUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795717969; x=1796322769;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/AAbzqN6gL/Sx0YtNRBarMK5mPpXPZmH0nkOki+mzQo=;
 b=cwVMlFMmZ+44MCS5uuz7w/bffN/7Use4E5OdOXZi8zc7XYLoBcnE/3w6h9/b/LOK38
 CIG4XB1aajHwTk2eWrmhpo6PvfeI38dasmU2huZmbmvcHFqSjEV87qphXoaKiodUz9Xp
 ccu/JQz9bIIYYfg4xrNyFDZ6090GCTw0/QPc+/MSAeJpCJmSCs+OOv0aU6j9PQRMGnOX
 1xP8iyzgTGd70XXM8d29SdObd2RAu9de+6rH5Yy41mvc6GCE4GA+ukCFPAnftiPusEnp
 JtoPtxz5Hb2L/sN1010ziXg2Aaz6z72DaXZXOGzJWb9eiRbq1gEtDjs0QNmGynzbhq76
 EXTA==
X-Forwarded-Encrypted: i=1;
 AL+hErHaQ1B9YHiJ3jfwWGkbL+3RrBN8Gf8Lw6V8I5LkdhBOxXih6bejh2W5FtQRVsCiGQ9uVlDLtS2OK7A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+VhleUoqMuOFCs3a4aX/4OUgg4skDMhP0iyJuI+FKnfUGbd07Y
 ZZgqSvSTr85OC0jamneQHZxhYvpoCzV5AffqksaHirbsQhLhWBcNkqDmlroixzMHM8eYWQCmhQP
 6XzPRGIzXuunzGg8quuueFPlr5N5L9fOjHe9PS6ZHLC78c0lYsJa+XqkH5vpXrtHTerXZ2Xs=
X-Gm-Gg: AZFdTZcis1hAJFohRWknb1AwT7LAsAe9t8mNxoZxFcWNUx0QW69ETfCFjbvOUGXCgv3
 cU+S+03APzV9047O5RQx7xFMunhesOTEM7U+/uTcU+cnYQtSG+xGbwuPLY9ZmbInymUteL6K/Aw
 GJzhIuGqB/bC0iOXz2JI6FPrjp+CFofGFtSDiptmZfSuyXS3yQWPl9uUtBPYSWzThTBL3z4zsOC
 P5pwGhPh4NJKhwgD5fdGEfBW+WnvkxTmPlPjPGJdUEui8WCqPVXHqBQXYlFQchadPmK7yp32oY/
 W0Rlalw2Dviijro/+yH7JCxEfJwYDDc3b2eCzoaNRUs6fbh6ZOSD86sFJhVxD7WYjIsGTDOOaGX
 Kd0S7RimvzOrayKhYwf/9eXIzPhiEC9JnQ77l6JHT2Ls/s7loRIzE4mLEtIICYc8f20uGxII7hQ
 ==
X-Received: by 2002:a05:7300:dd46:b0:385:7762:e1a3 with SMTP id
 5a478bee46e88-3857762e729mr21207586eec.24.1795717968908; 
 Thu, 26 Nov 2026 10:32:48 -0800 (PST)
X-Received: by 2002:a05:7300:dd46:b0:385:7762:e1a3 with SMTP id
 5a478bee46e88-3857762e729mr21207541eec.24.1795717968385; 
 Thu, 26 Nov 2026 10:32:48 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385f68bc0adsm60895320eec.13.2026.11.26.10.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 10:32:48 -0800 (PST)
Message-ID: <5ade8269-bc76-40e1-b0bb-559d3f211fd2@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:02:39 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/msm/a6xx: Add Adreno 753 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
 <20261118-nord-gpu1-v2-1-8d6d9908b7c5@oss.qualcomm.com>
 <a005f8a1-76a2-46ce-b328-2063bc307758@oss.qualcomm.com>
 <70651641-b264-43cc-a745-178ef2b02680@oss.qualcomm.com>
 <6962c4ef-ad14-4984-9df4-4624c4bb50ae@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <6962c4ef-ad14-4984-9df4-4624c4bb50ae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GPe5ifWcqqg9GP1qxjV6if4Pd0cYt41Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3MiBTYWx0ZWRfXx+YyS36MWqUm
 j18zdDb18jXZEA8kMIbT5cpfUWS+kwMbOGWaYcV3KsB66BYsNARN1EpJwd5J6qV4UR1X4yMBCnb
 U91JfTdzmOJ3zKi9FNYOfc4j0uvRIvvLhRWyRl3SnYfX4qerzO4CPCKBiJK7Sdkmm1Ypy4dheK7
 siIncD4c9C1K0cN1oiLyVR2IsVCWv49yE/i4tIRkxwT+RwMhQbYMjz5r//h/9JbVrAPdHFL26/v
 e13DHPUCiVQ8CFuD+99RlFlt7z+DF2JTEbKh+PqllPSwo0aBFEC1u6muHrnQQzuvezm6JEI0Ju6
 zI//kWWElDNWXmg3SeWcrGRrPKorDknRHRd4gN9sgoG5K/S44HgxzzXzT2+2W2ljlW6FPd5NW3F
 N+L7HhyhIaawBR867f7/8gxUmjCSfbebRLl9vsMWCPiVf5Og5dU3v2FWz2fcGVt1Y9kKe0f5npM
 sQlv/XcN4pUbJaQfFHQ==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b087b52 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=4rBPJfw8ZRJ0ovG7S4kA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3MiBTYWx0ZWRfX+h6xq98s2Mzn
 F87vi+OcyJrBGuFlqkKG/fES7WgcYzGYkSA3gVoHTUlfSLs6y3IbvyZEpHomhU8fC3WriJld6Tg
 FScRMyBbe3rSoVOnO3xpQ2e50GJa6qU=
X-Proofpoint-GUID: GPe5ifWcqqg9GP1qxjV6if4Pd0cYt41Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260072
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/26/2026 8:59 PM, Konrad Dybcio wrote:
> On 11/26/26 3:53 PM, Akhil P Oommen wrote:
>>
>>
>> On 11/26/2026 8:17 PM, Konrad Dybcio wrote:
>>> On 11/18/26 12:00 AM, Akhil P Oommen wrote:
>>>> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
>>>>
>>>> Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to
>>>> the A7xx Gen3 family. It is derived from A750 and shares the same
>>>> IP-level configuration: protected registers, pwrup/IFPC register lists,
>>>> GBIF CX registers, gmu_cgc_mode, 3MB GMEM, bus BCMs and preemption
>>>> record size. The differences visible to the KMD are the chip id
>>>> (0x43051701), the GMU chip id (0x70d0000) and the gen71300 SQE and GMU
>>>> firmware.
>>>
>>> [...]
>>>
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> @@ -651,6 +651,9 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>>>>  	if (!(adreno_gpu->info->a6xx->hwcg || adreno_is_a7xx(adreno_gpu)))
>>>>  		return;
>>>>  
>>>> +	if (adreno_is_a753(adreno_gpu))
>>>> +		state = false;
>>>
>>> Is that intended?
>>
>> yes. It is mentioned in the commit text.
> 
> Right, it says 'it's not working at the moment' - are we going to

Well, that clarifies that it is intended. :)
> have a moment where it works?

Yeah. Hoping to enable it in a separate patch later. It is under investigation.

-Akhil.

> 
> Konrad

