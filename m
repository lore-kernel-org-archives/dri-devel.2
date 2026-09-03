Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C70C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F76A10F522;
	Thu,  3 Sep 2026 11:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lb9XuRrm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZGWJ/3V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B3010F532
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:15:00 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHBxA3782253
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 11:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lz0OEqSGbW8F7CVDGnfMLcxZ7fyADNJyjt3Y6EUKNBY=; b=lb9XuRrmltfl6Z79
 AA4xBVmMbJ53trlzoA8ZhpUnXj83wUkuEgnL04xypF4ugEBxbdx4jgghjzdJuERT
 B2XBm1SCP7d8A51+SU/RSYhlhXMJNZH3W4O25QA1ZCsS9WRzS+LmKWhtye1xJkH0
 Hl3FeLoKXssQRqYyC2/on1JVFJO6g88E2RH2LPE0eQta3NngYPBgUmCe6rISI1xN
 imcn59H6o2DZJjd0JbrlKLY1g7ca+PzRhGju+V/VaYkTBELa2E6XNGI6iGFjNrOk
 f5hziLodyYWkUNDN6HRSQAcPNpcgN0q8o1B5rpxATeBTGSUlqyL43YxHkKpaYkAu
 FV/u2Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdrkkn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 11:14:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93771aa0379so607011885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788434099; x=1789038899;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lz0OEqSGbW8F7CVDGnfMLcxZ7fyADNJyjt3Y6EUKNBY=;
 b=LZGWJ/3VjpLejE4tg2fBJZtzi1QgMJHnyAv2yoORBIs6q9fz0O/o5W/GzwZ4FBAM/f
 Zk/+Icdjy8bkSWO6bqESLD0KvGU/vcMkim5jJqeLAHOFFQmj8bydfOn6cf4q8B7FSe/x
 HKzQNgMdi1JpY5nb2GLBER6SP3YwW+sPNiZ/UKc6y3GjNJJEPj/xxB0c6DJQCwCCHGqG
 4I+QGEgDxhr6F0ZsNDMWLyEvHl73lsWT35P86ffvdH2wKWzqZwCteTs6j/dxeFHMOa8h
 vWRwTuTE4nMmblJvyqB3/QCye9JEaBsKKs5ZyjvTqYz2ge3V9VFxYvnnqcl+XwWxG6ZP
 Kw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788434099; x=1789038899;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lz0OEqSGbW8F7CVDGnfMLcxZ7fyADNJyjt3Y6EUKNBY=;
 b=MyjVnSRTAgNNwCm+3ww8pQfbO0n2iwhOHQLEp997OwaD6KMnXZTKarDLhh4pwZJl+D
 xTU/UeQYahah99xXBINGFAauZYoqnthHX76PAINSMyFX07rZQd1Xjud4tiKogXIWKZ8y
 OzL0vyeRCbEg7EcG8lEfMIGY51zkMEfSMCWGEna20W1l9ETpQ9JusISHj21qsg4Kloql
 i0Dlat2wfiEJErtqUxvC/pm1qHfx3mf9qckmeBE6nbLbbcdPpKHgvXgzPO16VXizr75n
 KpPv5ZmcgY+jq4HTRn9Xu5X1a1S/V/+lXi4UuGoBOawJCHJj/jp3rMnPrWbDXi0G5i2a
 tixg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbKmLVzUs0KEQcHlgws8sgINCZsNs28BsJJdjoQ/JUJCgxfviTfi/OWyipvnZ8ObnRC5aHgpZOm6s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQyIx3gM5JttzJ86hVrL6F6dEjPQ9v3xr1qd4mPfMdPjgFryMT
 GTqa0cDHO3UVe0x4DNzDm86DMWv7ltgXd7Kj+n1bvVAamnbmtzyMkSXA+KRpUNjxDEwqqhQ42To
 mij9mIDwICYBbEEWdSnxjXYiNPjhF+8Fgzs7B1BMaCRVsn+eSa5f9rPfK1aZG8hFRQ10wT9dfaZ
 /gn6M=
X-Gm-Gg: AYBFou21PuAujFOIf9uOC93JkfQYi5Zi1t82S2F/l2asQddjnnmIZed7ovNVFu8Gsor
 yi7RkBVuQgngAlNNiMAodo2P7J3dVCOEDnqDvNYa5cYujbh3bkJ33U4n6q1qEe8XhtZPuzoJpAo
 FV1bDs1ZcFLDQe+7wXUtHdyMUA0dpJKAV3Rogzo/eIfuSooe6sSgY0w9GQUXYT9fgE1ckii9T0T
 lHVP+bUB7zX+C0P1YoNzT0Gmjbe5dJgXQs2KqwNXkAuxLXE8ggfSnyY+MGbB5BMhyU1ypBWFOsh
 SURnB2neFIUWmCNfUNnQVgV40SUTb2nDfiEySdUJE3SzsMX1/wc9ImAQezo8pNqZP1Pah+ruoLc
 vPU+0GLDa3VkX9CdUbWbpEcNDPsjG
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id
 af79cd13be357-93960ef3c8amr1369313085a.24.1788434098801; 
 Thu, 03 Sep 2026 04:14:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:939:1459:efb2 with SMTP id
 af79cd13be357-93960ef3c8amr1369305585a.24.1788434098304; 
 Thu, 03 Sep 2026 04:14:58 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5dadddsm73748635e9.9.2026.09.03.04.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 04:14:57 -0700 (PDT)
Message-ID: <34a028aa-d17a-4a59-bd1e-26ea784a8401@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 13:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: Fix setting completely bogus rate for byte
 clock
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kavan Smith <kavansmith82@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260903104732.145353-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903104732.145353-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5NyBTYWx0ZWRfXxCibanp7srjk
 oE+lSPZNyp8G7W/F+Tp2+QOd7/u5Gd56q7TMo0u20EnQ3kx9pZyMiN6yH34NYvFnucdx7L2DEVC
 JhcKv4a9cZwXS+XQJNgBWyBDnYhbMLg=
X-Proofpoint-ORIG-GUID: vTpO_T-VPChMaJhrEF0PbHPaNRNt2dvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5NyBTYWx0ZWRfXwXGNj5UPtyP+
 xH4A/uMqtgybE787Fp4VktQBs6zf9Xr/Oq/Ywi2/SWJtcgv4A/FYNZfrEJrmwaKSjtQOpyNBcYl
 rD1BOGDKAFlhte3iVaITY7JvXepQWu9yTyDvg7GGQpJ6Vi3MU6blt9Uq/72Vhxl+ACDMgz15GMO
 vdfR7dlMVozkA8cYvcniuXbZ1drLR4yP46TNrXmXFNqHo81DBekk/6xEDRXAOQyVHvhLzJDXWO0
 4eSAr7OXq0zTMgR9VS1a9DHJal7XZJf25+D9/thcl1huNzzM0876A4PJ5UAHnaOz+B68Pvj+MuS
 ZIGy0nw5kKN8smTIdI3h8v5vShXO5DD343memXR0TrdNbEUbN9OX/PRw7yk3qbeclsX7ULZZQGw
 SBxYNYksOlPcW5HX/y4o54fN79HqpibZ1Q2lmu2k9dJKrDdm3nwyxK3Ea+vO4LNBOrAMfsyxE95
 F4ZYhVRYEhXST4Piiiw==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a9956b3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rFN8pUq9rjxbytSTOF8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: vTpO_T-VPChMaJhrEF0PbHPaNRNt2dvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030097
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

On 03/09/2026 12:47, Krzysztof Kozlowski wrote:
> Revert commit 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to
> the PLL-achievable value") because it is absolutely untested on newer
> hardware and obviously wrong: it rounds the byte clock when the byte
> clock is not parented properly, so the rounded rate (used later to
> actually set byte clock rate) is 19.2 MHz.
> 
> This broke DSI display on Eliza and probably SM8750, Kaanapali and many
> other new devices:
> 
> [    3.164727] dsi_link_clk_set_rate_6g: Failed to set rate pixel clk, -22
> [    3.164729] msm_dsi_host_power_on: failed to enable link clocks. ret=-22
> [    3.164733] dsi_mgr_bridge_power_on: power on host 0 failed, -22
> [    3.164760] msm_dsi ae94000.dsi: Power on failed: -22
> 
> Fixes: 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value")
> Cc: stable@vger.kernel.org

Actually this was pointed out to me, so:

Reported-by: Abel Vesa <abel.vesa@oss.qualcomm.com>


Best regards,
Krzysztof
