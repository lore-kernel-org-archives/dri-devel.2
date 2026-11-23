Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EB606A682
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MFZ2YcHi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=efuwAqmm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15F910EEC4;
	Mon, 23 Nov 2026 14:58:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC1210EEBC
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:54:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKpMI2369001
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cjdhAiDDNjn2+9CEOyy6QSd/w/KllDQxmuyoGixQI3M=; b=MFZ2YcHiETwRhg9/
 DIdZ4DGjkEzUgOGtUu450VTuKRKTfK9gvPPVXbcnks5Ibu9HV8WSHmOi887T1ZhZ
 7uKeSUY5zbxBymI2R2FHR2fpV7Cfd5GQHpgtoVm+o75PYmfAJjZZ7ouWmko77mu9
 UIgMVjfJS85VPNmEBhVjryo2tBfG8LrzNmyZV83s1E8kgDpIEIFMQwL9U08q8d7h
 fWgES4y1lnUEEbjNyXfLh4Yp+4vv0E0Zez0eJaxcyeYWchblMHYoHobsT3YydFWr
 1VTOap3EKB60jYHBv06AZBBpGQZfU6EUO2JtluqXoGnatsKWOb6Dj07T3AdLPgc2
 kn4ahg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1p9vcq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:54:41 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ecdc7807f4so112061e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795445681; x=1796050481;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cjdhAiDDNjn2+9CEOyy6QSd/w/KllDQxmuyoGixQI3M=;
 b=efuwAqmmxWREKsIg6UvcurFT62wJ6Ela5G5dCfB2+DPLFk6jmRbsb8u3hqJ5IDnLRL
 YUe/UxU5lwxxsfKziwkFxjWL4oA+eBbNaDdZymhSC+x9volM9Dc4+HtPG/LW374DCFgI
 eVySCoQaafH0KXIb8F7azCwv0NBVtLMpmVUEmwAUXoCZGYkTBj4UZ4TlNwj7j5g4CCG+
 /1/nSjGbuGQFecW5hwm88ra+irwe3yGvyZkIQMrDv3LoH6ClqAuxbtwj1hbFZhW1tWsp
 lisSIB1yNP8idxLQvRM7PBoMC7lMd8YcZSSFTxPCG0A2Zrb9WTdXUSM4BNmDy+AkwdZN
 BkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795445681; x=1796050481;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjdhAiDDNjn2+9CEOyy6QSd/w/KllDQxmuyoGixQI3M=;
 b=Zf1hkkK8dWgALcH116idHPRHZqFaMuHoetVpvbbX0Mhw0nYBsayrzO8EusUQQs517D
 VQFPZd0MG3cFt0aLiCGgXn7yS+d4Q5XBqdzbiXyVNbh60GHHLQ+wt5CgoroV+KJ/da4/
 uFdaatOfFS8hZoaV5CEI+1kVpIobmKP7sQY10F1ZCsztBkWOMCjL14miFiaPuP2rU8Gr
 DpGjw5BzFSzrgIhn4OxTJuCfVYEp7Q8nvzJ6IF2eCnIMEjjV66m5D9oMwK67pkyEw9dO
 u0rlElLs/Y+xtlSEi7tnix2ftxp3X8h8S39rBm/x7vjogSd6rIHK6g2Dec6opCHcjuDz
 3xVw==
X-Forwarded-Encrypted: i=1;
 AL+hErGHciHG8odrdyjHpdmIxNsnor8NvijJX50msFsKdRk/NbDGY8ypS9BqLcP7sFX3dzvjwTfrHhE3HnY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9VE4PaeG0QPhIN5AZUoYgtE46AhCFfDs/CeAKNZfMSXhC3eaa+
 x01OCw1CMLygdmjJMbn8KkG0E8w2vkExMpVu3t0uzQjb8u45Fs6nk46wuoh0/TWQwBECN/a2Z3N
 5SqFHEQYxF7xTzSPqZ9UzCIOLO8CDxmG1DTUysbq8BxShp8Nw2T+9YtUKOYVQNM2T4GuTdrE=
X-Gm-Gg: AZFdTZfvKdKbPCH68e4qVM/jjUe9ffB2PlHJfeg5u0cCqRvHfVpIhbjb0/eocaGpG0F
 LAi0FyXwdLQutKs+2wmu4rQKPLmyaPn12NGTsZKObkQpqDLcl5ku9L6mtJzSzTnrZ62UvGbbLuz
 ifvH2EuMdG3MZsfKXqZgj3nce1+q/HW9EUSE4dBDJoAZIDOCt0NS27mgnVV8mLnsP5Y4TVGRcwR
 AIvDBaEWJgLaPXRKGzhiRhWCHyCOkdmj+CUiWz8I8nvV6rYa4vsir79C4iQ/joyq5k8tJ0MSL3P
 dHyj0s891Q6ZctQ0aPSASAkzrMo9gZdZMPPZOrXm4+zev/b+ldsulNBWSfLFoRF8GvWZ6K1KrCI
 aM4JYd1UAu+iXCJQrEN5AAEFWXb0oR0pi6YrpiXqzLHmad76UgaqcnVzILI95RfJ9j/OOq+U=
X-Received: by 2002:ac5:cd3b:0:b0:5ec:e2a2:b70e with SMTP id
 71dfb90a1353d-5ee8af4a71fmr5979647e0c.4.1795445680868; 
 Mon, 23 Nov 2026 06:54:40 -0800 (PST)
X-Received: by 2002:ac5:cd3b:0:b0:5ec:e2a2:b70e with SMTP id
 71dfb90a1353d-5ee8af4a71fmr5979593e0c.4.1795445680363; 
 Mon, 23 Nov 2026 06:54:40 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513aea6e29sm413697266b.43.2026.11.23.06.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 06:54:39 -0800 (PST)
Message-ID: <52bacac3-557e-4b2f-83eb-3c82fdc2ae9f@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 15:54:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Use div64_u64() for the retired-submit GPU clock
To: emcp@enser.io, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261122-b4-drm-msm-retire-div64-v1-1-94d6981799d0@enser.io>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261122-b4-drm-msm-retire-div64-v1-1-94d6981799d0@enser.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OSBTYWx0ZWRfXzGbZrik8GjUq
 MrUEpOdkverk3YBOhjZqmBnPs2BBL32iVZUNjeOhO1pp22N9tdmhjUvy6GR0Tf3VZNV1S5A7Yt0
 AAzrvECGmQ86szZeOHJ24PsEtOk5MYi/BgRs3sl7KIGnICY1IKBZZB9U2jFMpNX3DEM7F/Nb1cX
 BKaFPXvFIVKSLlZq8IZ0rQ/p0XOA7B6jF4IVhA98HwmpuhUVp5fkRh4v/4b7X+MvLFsQzOJd8tZ
 +XlF9OJD8MumnXfQxFmrnR6ygYq3zmbH0a7V523deK4uRdmMjTuKZkk7nKxrKdWcLvk4JrMoADZ
 n3xddmyPnJkOabo11mWZlPjFp+gaigXpeK1CvQmxzyGAfNdAYCkXgw7CnMTCFyPmWVLIebg7DTy
 lH+TaMq+3q3Tom8Av85vHvNRTH2IdCH/RDogVkSC5Oq4I/eNvt/y9+DWOCRMTDxcqNaUHxTa2/e
 Hq429I8/I2Pv3CQLwmQ==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b0453b1 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=l1nHKxr-XrZQ-B15pWYA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: swXoDdslXIEJMxltmMqxVLnqAMfUaiS8
X-Proofpoint-ORIG-GUID: swXoDdslXIEJMxltmMqxVLnqAMfUaiS8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OSBTYWx0ZWRfX9qtWZzuH9Z3t
 UanJBXr1Lnl9xMetKJ/H56fZjMU2qW2aoZMLfVOqR3MoIHhh8RKzzkiVkR0fRM7xCMsBq+cNV5x
 FREydX/Qz6t5W79WGM/D0Bo2b/pTT0o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230059
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/22/26 6:12 AM, EMCP333 via B4 Relay wrote:
> From: EMCP333 <emcp@enser.io>

Hey, thanks for the patch. Please note we can't take anonymous
contributions:

https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Konrad
