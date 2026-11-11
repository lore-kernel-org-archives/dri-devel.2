Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BCB606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WA4r7QNw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=efUcIZpM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B6A910E3C4;
	Wed, 11 Nov 2026 19:05:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A1510E3C4
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:05:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABIpXPb1526390
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vHQpceOMVqrxK4K5nhzSoZfKVb5Q6Arz3ZXzuTEVYQ8=; b=WA4r7QNwYdUWzD1g
 ik1urAHVhkUJ9bk3VXGgwlhcsaikJWbfCrXBb6izH5Gfe06Zx4kXTHnfndj+3Sjd
 5JRFprhF1M1qhbxvBEzVhlOAYHET9SZBZaVdom5T5ha5fgbZOD/4DAAIfXC+tk16
 pt/mj3d4+7WEWUIQkp/RvUsEu8dGMdUPprrekaTki+X99MXMqONYMLQsVU8lTevD
 B+4+JDh3lIiVAhVdFBV8pFzU5Tw7V4LQ3cHyvSa8i8fWudR+K+zwptxCxeGzKMgb
 BFaLCsIhkbpS1/FpZQx8F7txXChQdWsWZhTJNMzQwtfdwThxx+4eoa9vNP8EEnYY
 7YcNcg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1r4sk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:05:16 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5ece7e4af28so2949687e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794423915; x=1795028715;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vHQpceOMVqrxK4K5nhzSoZfKVb5Q6Arz3ZXzuTEVYQ8=;
 b=efUcIZpMC3m9+PNPOA8Db7xy+MACYbr86NOGl6ZwJklSykIUZM+ixGMj0BzVCcJEuQ
 1ckqfO/lAoi/iOL41kOJzrhDZTOl8tJ982yqfLRcn4qyFX4UblFDMZJJFuCBqhwcZ4OY
 ZIwbaHe2PYJphpg1W6SiZJdHMPi65ukkLv5l7v0WAcg9v2vqClADcYcvLc3cpxkBgpnK
 +kOwOuu8/qO/Z6wQrfNT/s68l3pn01RcsVuUt7qiq+53VNEzGMHXSoCOrqogFbhFfUpu
 wystQgfNIZ5begGTMNmh9QfRj2cn94KQq3mFspTp78wqoHILarIpSrjLGp4W/znavQot
 gusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794423915; x=1795028715;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vHQpceOMVqrxK4K5nhzSoZfKVb5Q6Arz3ZXzuTEVYQ8=;
 b=Of/sMR2pkpWfD0LqyDy3JAlIRh2B0F4uJfgxgoYqqFFKFiLfy2pM7qXfiyhwhXihVu
 Dt/xTVxace3fFAsOyGHGY21t+aa/7zACc4BjWyKjxkJfd5q/zTMl5F9z/8vmvGhCpA6N
 q9S8koOgOvcYv2YpZ0GqYJvUbtqanNZCuvcXXBKVV9E3m7PSayrDXENXlzInCtbn6sHS
 Ffkg0TdCTWYcrtE9uSQ1uTgw2uZ9VoGepq59OfUZ4EQDl9dw5UIdicDgNf7rymhY6J07
 vs2WkFp74O7klEraXuxs1ONNEcNqViaOHwq9/25en40AEczHaD5wzDNAAHR3W51GVjqO
 HMqw==
X-Forwarded-Encrypted: i=1;
 AL+hErFT4BVr5Rhh3aRF2iFBRN3LKLLIhYRBDw53RBmhFftwwXE3Y0zEJJw0bvdZhTDT4oEi0VzwG2P7ivE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Og0ujIDb4im6lO41pETHm0BTS8LcyhQs6aUi9zsVPPkR0K23V
 pdHfgy5823qRGWVfzvXnXEHEExqJHyQvNOHQNoubioUsymGcoxjKeAa70Wl8xEozcpZMxS9CRsH
 wevPCY7y+8vkvv6COWlygjyDqVUYA1d4XNgax9eGdM4GodKJ9VloSRnhDFi9bnixtKOwqJY8=
X-Gm-Gg: AYBFou0w7Zd5bnGesFuJZa9Rs6JtfY6OzXla1ySwiWTkeV87ncf2d3PQ4DmTxWiOcxv
 lMnnd+T3HCi8BsXec2ockvCQHG0BUbr09tgR+JZUtLLTcZA6dvmIZeA0V2W7d3GKg32sGJKJ0Qs
 cmBuzJcgvSWb8bTYPUNrydZwr/LlynSEMivN8Fo2dflastf3QAytzntSjrNftCa9O6zkD+JsJnq
 j7zwkO26ZwAeo7C31zDO/RmHLYCKSB+PhdLxnFG90hhruwRY2Rozuub+CqesNOOdmJ75aNJ+mmm
 vcEiC4yPgwRP2NHZJI67X7ygiG0tje1iWY6qhtdljBJHT1tt/073Dwi7py96sq7CZYXbEenDZFL
 8ePbm0GiVdaZpTBJcHpj48zuy7rANpxaLmeg6lChthm5/xyFSKuBm3s8Ekzzffy52d/ZBazNXqP
 Y=
X-Received: by 2002:a05:6122:20a8:b0:5ea:be1b:1b24 with SMTP id
 71dfb90a1353d-5ee1c42fdbemr1303139e0c.13.1794423915177; 
 Wed, 11 Nov 2026 11:05:15 -0800 (PST)
X-Received: by 2002:a05:6122:20a8:b0:5ea:be1b:1b24 with SMTP id
 71dfb90a1353d-5ee1c42fdbemr1303095e0c.13.1794423914770; 
 Wed, 11 Nov 2026 11:05:14 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e1f5810sm9023055e9.0.2026.11.11.11.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 11:05:13 -0800 (PST)
Message-ID: <9e2aba1a-61ea-445d-ba32-95ec57ab8139@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 20:05:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8916: Disable disconnected DSI
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
 <20261111-display-msm-of-graph-v2-1-fdf8fd97f49d@oss.qualcomm.com>
 <sashiko-outbox-209493@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-209493@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af4bc6c cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=nhleFx_QHpCl84HZKpIA:9 a=QEXdDO2ut3YA:10 a=arBHhYMabMMA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: ljPjJS2D6ju4Zv-N0tdErH9GJ1v3Sbfi
X-Proofpoint-ORIG-GUID: ljPjJS2D6ju4Zv-N0tdErH9GJ1v3Sbfi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfXw2rW4iWALChd
 QEL/UL8ZXq5T1bSJGDqR720FHzDHEi2pihqNe4EtI/XN85NZidqgC4rcfIwceMq94NpDdH5qlq4
 ZU0/jrrBYiE/T1cV20XFWxhc8qaSR+fc8fZBmSLAY+kc/qaTzDpFJh0b8H5COi9o+jWxndinwQb
 uFiuEbHqYRLImx69rSgrl4ghBAAWgwrclLYxn25leGM9Su4DOioUAlaqw/rcBVcb4nhwydrmo2h
 EkfxDo6nDjINvJS3F9wWmpQRtMGeiUi5Vfp/VmfHdLptrYHo5mxXkw/Ela4N/PP8nxtAJMe/401
 kDFdyBRGQbQZn7M+QYN5FohDkDnIGFzfIZYkmJsU0qwyODXviqPN24TT768MKdQMvXdTBfmTqQw
 KclKu09QKoqXiDeGfeQ/t7xe646yeRC8NLN0j/m3eYiWPbkJsVM1++HpzwTVK3UIi073eV+NNho
 bildQPo58pv4hsuf1Rg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX+Pjvv9Br/Zmc
 cOOVHu5zS6KM+/y1uw+HT8vQGC//KI+MeaOqBT+ZwwGxpQqkuGcv8cELGdK2gXfa0Ye1Nmtg0eE
 RhI4c/H9ys4rHDxult/LNKQi67OM/RE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110076
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

On 11/11/2026 19:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] arm64: dts: qcom: msm8916: mdss_dsi0 left disabled on apq8016
>   boards

I swear these were enabled... ehhh...

Best regards,
Krzysztof
