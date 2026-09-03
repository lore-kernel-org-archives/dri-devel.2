Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1AEC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6952810E195;
	Thu,  3 Sep 2026 12:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NkOAFKZ7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YXx7z+rv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA4810E195
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:57:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHV0r3852569
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 12:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HwtjBaZlwvf90l0KsuppypuDhX9EJ6Cw6utM7JsqnMI=; b=NkOAFKZ7LhfpbiDw
 T3C6WSiykerqrk/l/zDgZiNRbJZ+2fxqUcXUW9USUTO7BMmsNcBTaKZOzXphFXpJ
 xthpyfZrnDLhsBVwtCyNmex9WZLIf3s7qoEV6Vvdb+2gpD1Yo0ITKIFrmdSBG9EH
 T12lnqqiRiz8yiZefVCg16BEO9w80kR1M+6PrHZLGUT1hXqK2bDIRnGmw5HzDDwX
 KO4vz+Clg2a8vpDwwvZuNQ239+DgFCkE5jXyMDkLmBWIIy+mBsaCDNRud8hafPkK
 +uwFwKl+Xa3XgGiCj/wTkVCE9vpkdbZksSuR9+/20xCouYLu9iKiLqOiEO2rsFQJ
 HETYQw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m1560-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:57:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93495488976so54250085a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788440274; x=1789045074;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HwtjBaZlwvf90l0KsuppypuDhX9EJ6Cw6utM7JsqnMI=;
 b=YXx7z+rv8hrYCJ1qyKos1Kl1STRRJqbzEknVqqCqttU44A5rH+MQAiA/yD8XE9Wc5x
 blvbn5hkRWUvoIrNjqRi4sBhcrdYgqXq3poBX47ua6bHrEiGLV4RwqOywcgTIGpjzXYZ
 YIefkL16hN1Jb4nSvtmWtkPdrHBh9Ujgsh8OpCEYo3SrThGIQjOHZZh2jZTUlLZ8WMSW
 AHOBW5x5p5HsYqk2svrl4OBIbIL1jMswdry2emh59XiSHy444krIN5+7KOJr5+IndN4R
 CXti0/BDe8AoiDxrBsZhaoRCpBmbn4efqEu7nmYSjWEpXy4clLgU6EgNA5uR4WawxvuV
 7OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440274; x=1789045074;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HwtjBaZlwvf90l0KsuppypuDhX9EJ6Cw6utM7JsqnMI=;
 b=SnOa1DrTm8suH9N5J8N9IWisKesvmRDyh40j17wp1MFyXIBUA9fSOg7Az/ktocO6iA
 k/4xsuTKgB8xRte6I2AkRGBNFtc9PG4gUmxf9EeOlAENHYEjCbccA/uym4/7EgvErJgX
 ZvhJIn7IpuwV/YUaKQRjmpioBmFEvQ6LMm4zDG7837miR8R22gN/n2P8s2SvD+Ze6nK1
 /uy7oVuDx+kGbbGBV+Ii4A/Y1I5HE5Bmg9t2MnDobQN2Gk5eG6aRhtiybn7a3K9ABBax
 C+9AhRr7hqWFZ7HJ6mcM201ywAFcJOj0uIrVJt6bdLcoKehge95+QHo0zrbEbhqpY4/U
 JM1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIiQ4atwh3qV0zqFNARLVE3HmCHniNEacgcIjavbVI4/MIVA3lpn6qUre0MaK2GXI4lB88/5m1KNc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nJRhRrEoc/+SuWmMTlF7wMEiJrIAvKdjz8FFnAwv5CeOiVPUsX
 h8NDsRUzvzq5Nczk78Av3x6pqyhpX38lMd6eF5GUWElB7N3uWuWxjKla6e/rcjKRMTOhVOPiAsm
 nV8WYr5UV+Dy1m8sswuDzSGXnBBdjbZs1lx0vZ1MVtVbUp5qxK40c3ZUp1hd8BM2DZl4qBU0=
X-Gm-Gg: AYBFou08lqqmKcjHBvz/87ofBkGw+Rr8dJhIpmFmvS02dX9gYENlAd+MbKRIVkOWcX2
 9jIsa22PVaIPwrcP+uuvyQZ7I0KKO/zIi+Mir783as2snq+XcMqMpozCuoDpId2OCpiK0esnXNc
 PDANH7+FJnxe4fAf27GiR4AvB8epNi1GsMd9ZwW6npeNZcgS9QCKiwxZC/451x9fSqZmj0poCvo
 4G3a2tb14Gtl0MlWkCCj5wE3fuUbX9M3mah++twy6cNRIl13IJJtCNe/ySGJwIJH3TsS5iEfm/1
 KvDG12Cr0TI8m+hqAeCojpjMvIxxBU8FjKJbBzhC3HbWh2hAhxfdrMJXBPZncg21PRs48KoFGz/
 NOvgyfc/r+C5zEziRh9VP2g==
X-Received: by 2002:a05:620a:489c:b0:939:6c63:a7da with SMTP id
 af79cd13be357-9396c63c202mr592626185a.0.1788440273733; 
 Thu, 03 Sep 2026 05:57:53 -0700 (PDT)
X-Received: by 2002:a05:620a:489c:b0:939:6c63:a7da with SMTP id
 af79cd13be357-9396c63c202mr592620085a.0.1788440273117; 
 Thu, 03 Sep 2026 05:57:53 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25f4172091sm94908266b.12.2026.09.03.05.57.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 05:57:52 -0700 (PDT)
Message-ID: <2fc08924-2ddd-4f89-b962-5218c31857f4@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 14:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: round the byte clock rate after reparenting
 to the PHY PLL
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
 <a3c60bf1-ef2d-4a6e-b237-1a51bee2dcea@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a3c60bf1-ef2d-4a6e-b237-1a51bee2dcea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zXPwRGJDPjUA0QxXbhRCJ4jqxbFEN5BX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX9C2l+SxlNHV9
 qKxaR4bXYDQnglIC9oiQCTiX5hknUHaMYK5BkQWQG12ptpxwhd5GDoQwHZolrphav4aeyKifrw/
 hFlARcbom2sXXpxJ397bmhxl5r2+l1ekh4gvWzIZAwesgkeu12g6YQ/cWNgPgS8vIhFDSGPRWcS
 KV8inq7mrPj01qyIfxPOgDE6clxY0Nij2feLJYKvxlk11eEZvEkKhBIJZytsOTOuYK6Jjdcipr7
 t76sTFWlJxqDdMqoFm5VXV4jFAFyqp73tUQ+GSjWZfCpP4THigIRKcqz8LOrOe8x6HHajzIPWsR
 7yGNJRbir4x2K/XD4gx1BHffKSsoO/NTS6NGnfz60TZgMz3tQPUMN5HHIorPstYG5lM9Nt+mD9w
 FN2Vu9gIXUlQt+S4Fwv/Y2WHs2GiWsZcp8NsuBGTvyfTEwvrWLSZPtcw6zwBo4usREfSFGu4ty8
 wrngnmnbN6FBk3rDKuA==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a996ed2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=LVy3vgBfuOLURpGlahAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX5uxWazOEFyh9
 3z3tGR4zGMZljJFYvztYxE9vhFUVgkzn+ZilveE0SF2265ur7qB0CyBqCGkrxLt+9iC8enc7OcN
 vngkNDowfg4yYeX9jOoa1E/7CHFzC60=
X-Proofpoint-ORIG-GUID: zXPwRGJDPjUA0QxXbhRCJ4jqxbFEN5BX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030113
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

On 9/3/26 2:44 PM, Konrad Dybcio wrote:
> On 9/3/26 2:19 PM, Dmitry Baryshkov wrote:
>> DSI 6G v2.9 hosts (SM8650, SM8750, Kaanapali, etc.) reparent the byte and
>> pixel RCGs to the DSI PHY PLL at runtime from
>> dsi_link_clk_set_rate_6g_v2_9(), after the PHY has been enabled. However
>> dsi_calc_clk_rate_6g() runs earlier, in order to compute the bit clock
>> request for the PHY. At that point the byte RCG still has its reset
>> parent (XO), so clk_round_rate() returns a bogus rate, which then ends up
>> in the PHY bit clock request and the PLL gets programmed to a wrong
>> frequency, breaking the panel.
>>
>> Move the rounding to dsi_link_clk_set_rate_6g(), which is called after
>> the RCGs have been reparented to the PLL. Storing the rounded rate at
>> this point still makes later link_clk_set_rate() calls no-ops in the
>> CCF. Derive the byte interface clock rate from the rounded byte clock
>> rate, otherwise it would keep requesting the idealized rate and
>> retrigger the PLL on every transfer.
>>
>> Reported-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Fixes: 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value")
>> Assisted-by: LLM
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
> 
> I don't have HW to test it on hand, but it looks good to the eye:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

for some hw that doesn't fall into the issue that Eliza and the newer
ones do anyway:

Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # SM6115P J606F

Konrad
