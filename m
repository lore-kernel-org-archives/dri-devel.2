Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA187606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eHbdGJab;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JpIscjq1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E888310E80C;
	Mon, 23 Nov 2026 16:32:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9DF10E80C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:31:53 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGH3gj2377385
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QWQfUVU2CQs5hbXBXzRNrN2vmZR+w1uUFsRo891mesg=; b=eHbdGJabfGjqgmQf
 FBotnItY2afboOHdhIHEIwSc9c5beOFkVg40vPCDOM1A+vK6XGbAA2+yd9++dvbv
 MZa4l6zplJEiBlzznNwBmEl0x7TT8KJGkxeTYpQ4YH6M+4fk5MdrR8MvgqYTDY8X
 11jrz1rKp/SI3UZd0MyzZ2X0hT//0Cj7qUaotfgEtjSSePUDZCYCysJ83mUxXSuX
 /mylFJD7t4fq4D2dhlP843gtZa3D1iOnIHy3fCOn40Er3DsPRihFANI+eQkmC4wQ
 MjTYMiMBSJQOE/l36avjZd5kf084nrmuhu1MF7Cf6TJGFYyoldaZBow7NMKHYyVX
 ZKZQvA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7usaj2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:31:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386b8624cf7so1451165eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795451511; x=1796056311;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QWQfUVU2CQs5hbXBXzRNrN2vmZR+w1uUFsRo891mesg=;
 b=JpIscjq1vUpGnXCblDHt/ooKFZZfe+zXWJdMQZoHeksYhBQrbbah6L+WHHiiMsGa9V
 Mtp/LhPRajgsdEQi05K2vZmUG82P1yyvW1niE6Ve0RkL06V9vO2tvkAe4iHQJwJn7h71
 TQz8NmHSSXYrOjD1wxHcqurybWCrPYKUTiMUdIHqCQEgDBR0Fr+d25IgxuvJr2hTnAZd
 lZ8sRrDL7E8xkxw5ZBv0siRoU53sB608CZu2k/2HpH3Lo4gW6etEF2MzG80X4VGve7Ku
 1uue58IbTOaIGGYiINCyTQ2nwjlVMz75iN+w8MGAOxUcDJThTpLkCK/shcPQIhUahKWf
 Jg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795451511; x=1796056311;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QWQfUVU2CQs5hbXBXzRNrN2vmZR+w1uUFsRo891mesg=;
 b=B+CflvITnZXQcSeFLT97Rjiay6T+eHiJbMNZoq/oNSGgy4qjj0lEkJupfOcdB+760K
 o9kwUrhAqhlzz501Ib1Tq19YOtoSpnX6CuyaVSH310cGu6/vyss+4p1PJ802mniMeVuO
 WVCROaFwwGqqftoxmO7rP9F/901KxGAqJW99LaBGJ8foIXCwe/lzur+iqzlFqp1EpL68
 LqhzXLvxUoUeJyYdnv9+dLicrDPgdOiVWtaxGEpDx8VXMIZjZtloPXEOM60SD6wGLX6o
 eRlMZr4/qk4O2MW7RD1fUs8o/7AtsCZiX6y8Xh0bkgAnEg9ihzV3QaYkCW/HPxH6FY/S
 Chyg==
X-Forwarded-Encrypted: i=1;
 AL+hErGp3n8FlX6LeEuZfCcmp518pAieSCruYfC9w+hOKp+hznSTJhlEJ8xQgxR2oX+yQvEqA+yIYs2HBPM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+DO6tJoZaHS9F3/JfzzIdrTtNH2wVEv30leLxxN+1dFUxcHXt9
 eLIe23QFJDt6XhqoSf+iKKVykwLRuUjguv/Uc4mtqjWKyEOjoVjCtUhFw2hMKa9HTG8FGmKOScp
 0tps3cW/OywxIROH3MXiC05K8OczcYat4rFcPRdeocoik7WegkhKA4tR3Mu6ewdM9FwJWJGk=
X-Gm-Gg: AZFdTZcP3lKTD145jsTlPrGPRX8qXDrbw7H3Hsr2H79TdPbkg4Tb388mHJNgUtqiceh
 JC8MitZSpRZ4prhTRM6CWacrcORAFCrA8M4ASRM5xiX2xbIXKoqaViqNg32s+BGyjT+cW52dcy6
 OKl+Ow8J4Vmc7Xg6YvpGyIrEOrFNmRBxNbT3DIOyoewp6Y2cijIFgGToTxvnhQDjFk2FFxMdfsR
 lI9Fo/5ckewZ3+c5yGYM354Ye5vIK9QPy3PbWx7a9rhF+NCfFC2zGRC6SsRLFOQECmDQsOtXRav
 nD5cEYKBKqz2fVvXkJjvqNeA82HyK9cCTieFyUDtOa+I6ECzGvrvJLfSPau7wUddwdj8miSjX81
 Vrhen0kkUzqF2zAoIWG2M06TUAJ1JzN6i7WPZgS3e3s0juJcwpoJIy6g8Xn/AcaV6YFV+PBOH3N
 jVXCJbaprHxzOauGqFAfUeUT4=
X-Received: by 2002:a05:7301:c016:b0:386:5adb:ac01 with SMTP id
 5a478bee46e88-3865adbb1aemr11664039eec.24.1795451511102; 
 Mon, 23 Nov 2026 08:31:51 -0800 (PST)
X-Received: by 2002:a05:7301:c016:b0:386:5adb:ac01 with SMTP id
 5a478bee46e88-3865adbb1aemr11664011eec.24.1795451510520; 
 Mon, 23 Nov 2026 08:31:50 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c371esm36944061eec.23.2026.11.23.08.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 08:31:50 -0800 (PST)
Message-ID: <e3e03774-f066-4cfa-88dc-183fb06d80e5@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:31:49 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Dawid Osuchowski as Intel VPU maintainer
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, linux-kernel@vger.kernel.org
References: <20261123122007.2580451-1-dawid.osuchowski@linux.intel.com>
 <d9b91e95-243d-4e3c-92b0-0355dca59a63@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <d9b91e95-243d-4e3c-92b0-0355dca59a63@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Sv3Bl2d3-0rlcPLJcDooLIwRfrYSI2YL
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b046a78 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=e5mUnYsNAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=_GM5mSVEX-FjDFjjp_cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: Sv3Bl2d3-0rlcPLJcDooLIwRfrYSI2YL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NSBTYWx0ZWRfX7LaNeIu3q30n
 Ek7dX79QWlH1EUM6Y/kARnSdnt4zjvSp9calgFCsMrA2D629JWrN48kw3j/0R5BBc1sBQQMePFt
 3kxVzpEg8bt6Ef3YJV2TyJPnvRXmP0k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NSBTYWx0ZWRfX+xSipYb5Zg0S
 nVFGSTjws+3Y5F3HDNpZFmpYvB9ZgCWAWbuAibHGSt4J4OGpetm+NFNIRQy72tcnVncTYZFbIcU
 K80x7sZLiMVLmVX+ZoKv/4TmvqdmfC6me+upszyvx+BqnZ99syMJ5ceAK1M7BaWP3l9ffyCgcYw
 mMtomhKjyewrLKiUjbbfQVbHYa+PcfXBnRhC4Zy7+rQmNCIQ6vwbarWAydhlynsBamd4ogrAfMc
 uA++b5dtU63jrhMWunI4vwGUHgp0RS3HEqatjBR9NtmfvGD52G/LHmXHC4IRkbanBZ0sXq9dvSB
 Kv7i88fst7KEr0GVGkIhO86CycyXtLRrqZGhJcT5zJdCSogC/ZG1B5TZ41p7MrT7Ipx/pnFST7V
 GqzVVEdHm6ydUT2k/V3GOjaVjXPipPEkQe0iY0P+Nhf6t7aWDNrUHtla/cwULtdZBugEFQBJGVh
 nP3eGp4mwK4A/u5+WEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230065
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/2026 5:38 AM, Karol Wachowski wrote:
> On 23-Nov-26 13:20, Dawid Osuchowski wrote:
>> Add myself as a new accel/ivpu driver maintainer.
>>
>> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bcade5bfbafe..0afa391498d0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8198,6 +8198,7 @@ F:    include/linux/power/smartreflex.h
>>   DRM ACCEL DRIVERS FOR INTEL VPU
>>   M:    Karol Wachowski <karol.wachowski@linux.intel.com>
>>   M:    Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>> +M:    Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
>>   L:    dri-devel@lists.freedesktop.org
>>   S:    Supported
>>   T:    git https://gitlab.freedesktop.org/drm/misc/kernel.git
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
