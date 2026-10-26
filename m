Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54715606A320
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fu3kWOGP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UcBj25gT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF9810EE93;
	Mon, 26 Oct 2026 12:00:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DCD10EE93
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:59:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt7lM4126433
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rtWr3blELUAHMd45WIMqDWi1b0Xo+6vTP24A83n8W18=; b=fu3kWOGP4Y6+tgGV
 FGGexaLb2UWT9K/cdofXCsW2OUbBfzOiD3adU29s6Ci/Was7o3avONGS3ytVbR3L
 djyGG2ZI7saajUZWdtTHVksfEzvQFmgeaoAOIKITuq2I3NcBpqRYDaqyGQ3+S1Ed
 yVzs4FPv+HCMsWR4yjd4T8IRT28gZH6M3dOh6gcIwfK2inOpxwkbN4BbqERcpwdt
 7ygMzCQzov35pM8ceIuYK5k6Rg2Q4maDpR5M0gJGp3VabfGmbde7P9eAy2FPwStj
 2n/uL9ltB2ls5YSDcu4xn0pCT5nR9GvQuyiqmCz6tFuDnI6gEJdBx6jnLJz/TLpB
 jg1kjA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpt8t5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:59:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93edac5877bso50589685a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793015998; x=1793620798;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rtWr3blELUAHMd45WIMqDWi1b0Xo+6vTP24A83n8W18=;
 b=UcBj25gTmpgTa4lqbNw6LFrhFP+ZxAR+6Z0nAUv8NvAX0uYcD7wJV+1CycJ5FoZE8B
 URiYokYhWNdugzlnT5zSV6WMDpNPq+d/XZfSNdynt26vKDrp4dCYzMdIwfU5+qyX3G++
 M3a7fZ8LU0c10TF/7/eH3B4b17+y7DzQnY/jkKJyWwJcaFh8WkjQUFn+8Dt3IwAiw2eR
 JV2E6mZ5hZCzbWhzhVblYyKt9HIPkTlHvG4AnIso+wBpTFX442ogcS3bpCYe7Z75CAh8
 sVKiFTmMgZLNh2ECncJD9tqV6M6QDS7u65ACXWCrX6AhBQS5kvJ54VKe4iYu9APwvi/L
 sNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793015998; x=1793620798;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rtWr3blELUAHMd45WIMqDWi1b0Xo+6vTP24A83n8W18=;
 b=zG7CZbIIOyfmD5fCImKyXo0fJ2be9DiUVE95cnuE1GaJFym0LW2x0IQrP4X/8IOU2j
 K9Z+lkHI9ZgYvhJSREdxWhrwi6kpw8LzOdsp4kIXhsuEWrVKP4YsrELs37aAeeCXHzu9
 ADTSgjSSPVFLknfqrC1iKzQeiQ2hxDyutzLmUfWwDoBNqSP6PZhGPP0TI/A8jM06Ar4f
 XT3QYoejZdCovee4BS47I0XCASzSOMjOj6hu4/KFGDygosEfQZuvUl9Ul6UetG7clL08
 92b9rHwacjW3WDFjP67QXOr/GYkGnN13pqfIrUGGS2byt0kUcaHwejc2wGzkFkpzc63B
 vrOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxN0tFnoL1+r8XMW2El/Hidzg5FFD25RFWBuj9GmOySCsOwUuQTRoMDD+81RLiOyjx4oJ4f73tSlf0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIy9zLdUbOCQvv49cHBfNo4ddkmm2MwEeElDM0DCpcGChGk6LVr
 iVm28V2j4VIHAwuMvLNriZ+WBpPeFk89w2xu9fDArOSxbUbhS/K7EnIPTH+xt2BrjgxkRJ3TYGv
 RS8r3NhTiANBZveODe+cnzs7RMkTgYonD20b+t2pykri4aO3600Zrh0/Fl1GYHZ3SJ3JR7gs=
X-Gm-Gg: AYBFou2aWPSxhh+1ygTjFPlxmQi5Pl8iGixl47qw7jz1l/bNEum81/M8x9tGWdICBq7
 ye3qI5FvxclBNXXxznag3BMDziZfWgmCDYFDzbWrf23wWt+G1HNtdyjeSr7+qhbOlpn4fM0rePB
 LMPzTRRGzLbhSJOTjqXO38W7p00/La5YyY9AeiAfZ8AlApeb8k0ZsG2rVzUZtc+944BRg3xkppy
 vpDuuxjqhgH8y3Q3nVo80gTnmZN9DJ1V4EEdxNIc0nUO/ONnjHjy5FiYCVC3vn6oDg9mMF3HZtB
 +9/kva2O4hnlxMwfKIVzNRUSD8SVc1vJQ5ociLie4JWjD8Y3Uo1YTlpWogexmnuVz8Q4lT1ZgKK
 8xBcXXFQhWByJw2EsvljRPA==
X-Received: by 2002:a05:620a:8703:10b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-940ef672271mr970545185a.0.1793015998008; 
 Mon, 26 Oct 2026 04:59:58 -0700 (PDT)
X-Received: by 2002:a05:620a:8703:10b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-940ef672271mr970542285a.0.1793015997533; 
 Mon, 26 Oct 2026 04:59:57 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b445990d9bsm3592295a12.30.2026.10.26.04.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 04:59:56 -0700 (PDT)
Message-ID: <e6b62824-8022-42bd-95c1-60322675d54b@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:59:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: Remove FastRPC compute
 CB9 entry
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
 <f0bd8179-f211-4d2e-bb0f-a419744de2ea@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f0bd8179-f211-4d2e-bb0f-a419744de2ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfXxHbOQxdt66KA
 eJVD0CNF+TURXl7DR2ZXDum6yHZZW/TkEIFrYIQyqHv2/sAiGtuOXbDmCSDWNDfwdogMLf3KJ23
 ko3/kw+HpA4TWPZQI0icIOWcsCwN6b8=
X-Proofpoint-GUID: mRKH9AMXc9XJESets3EYnNI-Kxfw4V5x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfXxco7frpWpZFw
 jhakOpICzVvN1n8+jM/99Uy19abZElEKYmkpHxu6ljQaE2BzyRwcHMGymaPtSpk8vDrovyxoXOa
 93tjW2/0n5OE3A64SeaX49rwFEu8k9oglIYywG1xPip21jPzDICD+QLnnUBzSE4IQsmehT+8nkV
 kvvVC5FJFe72QuHYJ0gzOs0M2pG1QlAY34Z5isxMRXofJ1eA2gWPc1awF1bgq+sGEa9OmbVw7jC
 pyHA39cXhJtqgHXTlWFKI24UncKCQ/w67ZZexnekBn3NJF/vWfw5oUDKiGlQ3HD37G3Vg72XmUd
 OnKaFYVpEyAkfwnBJj2hEEahVcV+UKYZjJA9gnrWRfQsXwsl05kHnDZ1ySOvzdeixsq689r6q+j
 eIz1wSgk338KCJrF9+ilagrTJ6bYGXS5ZBTKnSU5yoc7uccaNKpO1R6j90bw9aydxRXcw2sRcZ8
 1CChqSaVeRcvlVmVlLg==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf40bf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Y_fbMFyzX05j7FwaadAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: mRKH9AMXc9XJESets3EYnNI-Kxfw4V5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260047
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 12:59 PM, Konrad Dybcio wrote:
> On 10/23/26 11:03 AM, Abhinav Parihar wrote:
>> Remove the compute-cb@9 nodes from sc8280xp device tree to
>> prevent clients from selecting a secure context bank for normal FastRPC
>> workloads.
>>
>> Secure use case support is not currently implemented upstream.
>>
>> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
>> ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Retracted - the doc says the secure cb is the one whose SID ends 
in 9 (and these should match the reg indices anyway so that needs
a separate fix)

Konrad
