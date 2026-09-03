Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDDCC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E6610F588;
	Thu,  3 Sep 2026 12:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VfW47nC6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LujHbXZx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FA110F591
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:44:50 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683BTJ9r210335
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 12:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jbhmEWvdbNRK9oxq0JthpnJ+qpXiTJ/OErPeQixWtJ8=; b=VfW47nC6CptIzz4N
 xCrqkSYCciajwjPt73KFsQ29skhlrNQQLca5IUAJdJH8LFkridW3MDQZK87ys4+s
 uauHADqA9SlzuLIMKFVDypoLS/6Z/ti+k2Epw1Wz2E+Ab0hEkYRvm9p23KiVpfhO
 9c5xKRw83AxbFybKXf+gR98HsaLG4w0CtVsb1heF9A14WMupR6im/IOlL5MuSscA
 tHPeqjYgqBqzcTdr5tMpSnsaMc3bJ565r22wzwaXhLQDOzG2ifD/6GeHJR/h6pol
 cjzez4WW0oOf6iPieaRbOpoZkRE9yeKK6zSRN6Z8IIiedpZzxg/18MeXIdkmJMp9
 Op0Ihw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf82k88wp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:44:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52ec554a80aso5751311cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788439489; x=1789044289;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jbhmEWvdbNRK9oxq0JthpnJ+qpXiTJ/OErPeQixWtJ8=;
 b=LujHbXZx86EslK7X9h9NWrNPOi3oS5wDu2RpEBuRBvxPQ+3fTyddS49w38CWfmBagM
 +eVgL31inibEsSMBE2c9/YGyXRWr9Qa0mP9ADQhJVuOSjZgJh6X7gyiGazFpXa0uF33S
 EPNpqwF5Bky9QkTOIyQtjIoSy6nHA/HnuR/XBTdb2bUdfwJEX5cokZ4A6GI1MiqWIzjt
 CGjzQqm2sSBML2cv7+1snumbNEx9fyRqPPK6r2F+E/dP+9hqDkzxOanZHeyP6VQD/jbx
 zUHUCvUmsMGCnm0igqSkOWZhu+hxnlD0OstMLmOyvjNyegkNRIp2KM0CvG4uhoUB2rom
 qwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788439489; x=1789044289;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jbhmEWvdbNRK9oxq0JthpnJ+qpXiTJ/OErPeQixWtJ8=;
 b=p37/BwcYe0MtQOt+rXgrGsrhgB6w06UTAYp5lfXqShBvD5LQYVFjMyATyG9G0o0LLB
 ZHAjxuuJtscTqfw84rXxibO9cBDoaCNH7k79APf7sC89+szq0X0aZysALy+V7+fnNoEc
 kpYS2QspJ2SdLTYJe7EQ0xVspHnCJuoF9yrFIGLOQZ9QQVHlFjnvka3InxZr0iAtFWfQ
 85NEAlsxIyvNm2RrfgS44mnfHrN8rl5jdcuz0fu578NyxbIgPOiNFYvCM8EqaR+9hBv0
 OPE3TdHuDQQcz19kC3F8tGDNaonE+yXGvLQZXURNyMuvNT+agrMe7+cVz3pxZfsqZQZf
 8kbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwE4peXTGs1ykXECbagTHOhqtoyKDcVUEZfC2DHi75UdGXlW55wxixIVHeXvnDyL03XNa8Ojgw21f4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ksCCCgTlGTJFRo0HQnjByvZhP6stVtiksVu5CXI664IEpcHJPr
 LpKvm2rHxcu3G3R0H93YHhjxKOEdNlEdUfwk+ZOGy+ZggfisdHvaFvLQIK15Jo0CMrPT0eJOEQM
 x96Z9KfmIGd0UkB3wa3ZZeJWaHxLBu4ivaD3vV7GL+fJ7Vk8eIStJYgeNYvxV0bx/kaROiQA=
X-Gm-Gg: AYBFou2ldq8cXOPCKdIvnm+1iqho/u7A+IbOF8uQBdiFiF/Bpt1Z8Ixsf1QZPpSyBDd
 qe5tfHcBdtAyuQSkNaw966VQxXGfC8MkekSHB3miqhv+yU6EoI+9OQ+tuxudsiD2KD5h6LnDO9g
 Y/3xq3D8uRD42btt0CDkwXqGoYy6i9UJ0ksMiHKb7r1GdBTkFzBGRwwM7Wzvxt5TjmniCIUaLDi
 NaFB5yuODkN4vA9ia7cjFO9bJN4tML9elcRrn+EDwMVxPoGHJUr7PR/eMqLdhObtQ/7KdhPt6jo
 ReJKVACSXdWQT4sszkvzGpvEv+S5RsnbKiAAxqYMbPJXNoSA+tsOpRkwDG4ecctXgBnoPvmgffy
 UJ7rTKs0XCW0JNVgRY8HhVg==
X-Received: by 2002:ac8:5942:0:b0:517:5d21:9899 with SMTP id
 d75a77b69052e-53036d8e031mr93074441cf.5.1788439488724; 
 Thu, 03 Sep 2026 05:44:48 -0700 (PDT)
X-Received: by 2002:ac8:5942:0:b0:517:5d21:9899 with SMTP id
 d75a77b69052e-53036d8e031mr93074021cf.5.1788439488091; 
 Thu, 03 Sep 2026 05:44:48 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a67f9423f5sm2205112a12.22.2026.09.03.05.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 05:44:46 -0700 (PDT)
Message-ID: <a3c60bf1-ef2d-4a6e-b237-1a51bee2dcea@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 14:44:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: round the byte clock rate after reparenting
 to the PHY PLL
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kavan Smith <kavansmith82@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260903-fix-eliza-dsi-v1-1-3474a6c9f2e0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260903-fix-eliza-dsi-v1-1-3474a6c9f2e0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wno1MUSqEir3xRT6eIhsOvpxmsfKT84R
X-Proofpoint-ORIG-GUID: wno1MUSqEir3xRT6eIhsOvpxmsfKT84R
X-Authority-Analysis: v=2.4 cv=OuJ/DS/t c=1 sm=1 tr=0 ts=6a996bc1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=df3BZnECoes8ZJFSp-YA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMCBTYWx0ZWRfX50L+kB337osl
 yJILXUgBNMpEAoQRfT325Bgt8J89S2or0DYp9+S0Ab6OZUEvheNeCtVhhd2VFnYpY3shcFDDOG1
 LEJv8t1RGrG8dlfqyFozoonfVKOTHeUmhU5P+SORDMMUeCPkpNhIbHtWHm6/4ProZ42qh1Zw8ZC
 NRTzH4jI4Kdc3MM+717cHlOb4Y2gOU273kc/R7CIuEZnbUB8NFYuIwlN/hBx3h61aPKfOzVYQVV
 yi73GwKGm3Dx3KbaNBahCXxhxGKcqSoN5khlemQzP14bWG1MN2GCPbXnTNDvgBCPdJLFJln/Nl6
 JY6hZOv2vb4tLzaByq1EkvBdr/w7Rm51ZYejEngCxHGNbCt++GXYqwpm1mF5Rp96dNKZftOGXUv
 Ow8gczcKifN4rOcN1ZEyOy9rEu/y5cDPt6lwGlK6brNyHy8J9uIPdPyMe5EolCDycnAmVg45jYK
 FzeY26JltmCS4a2jc6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMCBTYWx0ZWRfX9HDuOszYYKV1
 4uM2UOny6fSZt4fUarWM6XoNOf8nQh8BY0SRZihiDujXKWzzMa2PXKC3atpkYW2AS9uPo7K1Lh5
 6raXBSnJ+6cnLwfAF9qISU/ELn+Ehx8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030110
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

On 9/3/26 2:19 PM, Dmitry Baryshkov wrote:
> DSI 6G v2.9 hosts (SM8650, SM8750, Kaanapali, etc.) reparent the byte and
> pixel RCGs to the DSI PHY PLL at runtime from
> dsi_link_clk_set_rate_6g_v2_9(), after the PHY has been enabled. However
> dsi_calc_clk_rate_6g() runs earlier, in order to compute the bit clock
> request for the PHY. At that point the byte RCG still has its reset
> parent (XO), so clk_round_rate() returns a bogus rate, which then ends up
> in the PHY bit clock request and the PLL gets programmed to a wrong
> frequency, breaking the panel.
> 
> Move the rounding to dsi_link_clk_set_rate_6g(), which is called after
> the RCGs have been reparented to the PLL. Storing the rounded rate at
> this point still makes later link_clk_set_rate() calls no-ops in the
> CCF. Derive the byte interface clock rate from the rounded byte clock
> rate, otherwise it would keep requesting the idealized rate and
> retrigger the PLL on every transfer.
> 
> Reported-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Fixes: 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

I don't have HW to test it on hand, but it looks good to the eye:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
