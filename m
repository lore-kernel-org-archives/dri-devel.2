Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD63606A838
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QwUTQ+xG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DqaSfE0o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F255D10F510;
	Tue,  3 Nov 2026 11:25:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2E810F506
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:24:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAMfN2554811
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 11:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iGMyTcAe2JPy7lK5xDkMwrISIdWLdzqB9J4ABUaidFI=; b=QwUTQ+xG6Mwg3VW6
 5DKhYqOvR4Rc+lwaP7zzeye13XKtbpzK2TyJJc5x5f4hBi6CFwMSl7bWR1S3UrDj
 aAsjvyiGSLw8qw4DEsByU7eUZT55uyDiN120EsZ1+gdFc8yzQSpDPFu1O91SkwKz
 ILEHpdKjsyCYd8ENqmkYxA0SzvqIpTHrgHR3ZlNyh3UqvDe69A/P02E2x8lYcTQu
 izCxscBLt9cFUzhZCqTNG499POX0bEBoqYipqz9FqNpg/i0WkoijsijjizUZRANC
 vck7FSDSPVGplNzZnhHdroETs39nFOykljvOrBCnKNSZzE1wBuSAEeTy7GaKCs5/
 2l0OsA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2acjvy9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 11:24:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91e751af52bso303206d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793705098; x=1794309898;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iGMyTcAe2JPy7lK5xDkMwrISIdWLdzqB9J4ABUaidFI=;
 b=DqaSfE0owSgheH3gFfHd95sjcuwCi411lEfrjx0QD4+SnLrGT4iZRp9hzMMWEukLl/
 yk4LemyiSHWsEuk26PnuKhDnxBpdtMshkiY9w/54bUVghmms7gEkmZRqx16q4KxWx/SI
 f/x8IrXgi++bYSSMGhRtyD+KVqPBZwacabwpq2UGCxR3jcZkOB2k59gkiZc3enpUS+MX
 NjsbTCkZf+AV3cqaJPPidGIGdie9OtsoAP6npyqfujQMPdsLIbjTrOQqp8VhyiRsx8dZ
 aq0KgcH469w9V8Q/z/azIDqqTugKm5kj41VRoE5KvFKwA5aIApPwh8OFk/KExB09VlB2
 MuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705098; x=1794309898;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iGMyTcAe2JPy7lK5xDkMwrISIdWLdzqB9J4ABUaidFI=;
 b=GFJmAe8F+/ft/F+s8NVjskxocIM0vczlcvdebkFLaJNyQ3TlR4cuqD5lVz/QhnmK55
 RzVM581R3DuDqYrywqFUHLMY4NTUlvuTnLjdPjdxukwa5hMUjVMUM1e5Db5CBou8dbW3
 OYlZuvqccmZU8jcdN3P53CSq+JhUVhBurmV4OTgCo85PGE0OzJgDHu+EnpWePy8vAPhI
 zlIVC1f7V50snYdmILOZTbK2pQ1n+aEUQYAtqZIUQfQWKGRZQjbBaK+LTLUZ5SizBuUy
 q3jb3B7oKts/F3t0WGoDSoe4P3pofgpP0NwjGklgmJpD0wr1tzqIfkqPK3DHEuSg4DWG
 f6qA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIkPNWKOke0nHUNM59K/ZSEj5sk1J1EuHIMXP4qF/0kba94WQw7JTkwJfuWTGwzhKDbnxqM8lQsDk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/+zlPuUJyShMUxiPOeg0U3WBSn7tRBsd/G9Jze4I9l2ckpxqSW
 gd724LFX3I0Z4CZNz7eqrxoMbbMv5L9066I9NvBuz4LHLh92EcVTmV//rKJJJHoAfmRrPnHHZ/8
 IDN+WJKrDRaPSYreZqF8Lw1jrZhe0Pteqyk6gjEIMACAz2j8RHJ4wN0/V9TOJ7QLHUlWT9F0=
X-Gm-Gg: AYBFou2lcwLvbgjpyk15xPtf7MYtW6bR3/AUVFND3G4ilg531DzFhlywNCMiJAYYUzM
 Cxp1liIbay/Cy78SBNkYBihoV+UMxUb42uR2RIEIeweACi15Hl0ykyoP/eyW7omnECS0LHKK8E8
 J8kYyaKuVAG6UtVMP6YPPi2BXf7M06MLqOvEoRl58A9D8c0Z8gbppp64aUYcu3+Y+MdVLvY0JrQ
 6p18W8cJgrsMCK4zEpyHf58rqObJeisTdKziZ7M0NKkQkHzk1ACIl8vCes20NBRx+N97Ph3AYr8
 kNF2HIjdWj0S43Xzn4ya5rS/HuiVce0aybTTqJblgxBCOtJBeqcxo0+KA5NHncb5jUGAq5lE/WV
 deNvXzWhR/zLP8gXNhcw+pYz8T4XizuYH7ekM4cjwP0n0s1PI0+g7DjuMrSbUw7OZJyU3JA==
X-Received: by 2002:a05:620a:3c87:b0:93c:c96c:a5b4 with SMTP id
 af79cd13be357-94421697192mr1942472085a.4.1793705098414; 
 Tue, 03 Nov 2026 03:24:58 -0800 (PST)
X-Received: by 2002:a05:620a:3c87:b0:93c:c96c:a5b4 with SMTP id
 af79cd13be357-94421697192mr1942469185a.4.1793705097997; 
 Tue, 03 Nov 2026 03:24:57 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebefde4dsm75525666b.39.2026.11.03.03.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:24:56 -0800 (PST)
Message-ID: <7ace2198-61c0-43f9-806b-e97b32b36c18@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:24:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/msm: Add cleanup help for disabling IFPC
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>, Sean Paul
 <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-3-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102190010.720443-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae9c48b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=cWb5AwZ_sP_0w0E8whcA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX/kRP5eSqEOk5
 pSRhbJ+WuA+fLr3fUL/OwrEANN50cbUJbcrOHeUrBUn5yV+XO0gcf+FXpvPzd+wNND8C/gZl0sF
 aWv2X9Q42rh8lIrgN9QkEUBVJgiMTSvU8HXYvfZ6Z9C4Xpmhxqbtf2W5Gf6ZyRvbSZ047ZxmoxO
 iL/HDYZ9FxCs5xncfcPt92hFOKpVVmylltQVTKYjPx5p5UH7QqRAaxZ++37pjNMD13QTIJLHSHw
 v1kElOpSRNJTTi78febipH7tsrYHG2sb2MVQzIDC06Ae3UsdD2uhTB8AXn38TW1LWtvnKobikIr
 K+p2ZRYCKsbmqc2tlEWkAY4d3/PInLkEeH4WiVUqZ46CdsgQkmXS+ha/pEVFEPPOkR4wpYBLaFl
 VSE1ysZLCBundxp0YCH/etQ6cPGGkkD8VE66eG3kByY04SmoTPWf0sCpvY5EkZ18PT2uVjzAfgo
 /O9lz5yU3STyQErkeIw==
X-Proofpoint-GUID: cGRh-WbS6KNQLxxGcyAyNzjw12eGj-UE
X-Proofpoint-ORIG-GUID: cGRh-WbS6KNQLxxGcyAyNzjw12eGj-UE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX809Se+gNrLlr
 vxNnjWkvRv5rO/dwKHM3yz4JPDAJ+JR2qYCjzYXfKtHwJmcOPPXaUSUnneo6Xitl/upAKvYSGoE
 TXzVK65TCCuqthjSGoCH4nsM/U3fP+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 8:00 PM, Rob Clark wrote:
> Simplify error path cleanup for IFPC-disable critical sections.
> 
> Note that this moves where we re-enable IFPC until after the
> wake_up_all(), but that is harmless.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
