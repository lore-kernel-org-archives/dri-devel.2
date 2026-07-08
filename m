Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CA3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 05:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5EB810E549;
	Wed,  8 Jul 2026 05:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="rUy27V8D";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71ABD10E549;
 Wed,  8 Jul 2026 05:05:24 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667Mn2SQ1238976; Wed, 8 Jul 2026 05:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=MhldLM9QD9GuE5p3/DJ9u6OdZWb/
 6XIIA3VNSVKn6sU=; b=rUy27V8DZ6AzXiG0CnEiKb1CPLWgpxXQhAx0Q/zTKn3F
 G6R0liofXi9do9o6LXs2gZ0t/+2YvoDiu2u5uwxSQawsYrzMVTkX2zL+mtZXg3hN
 wqlGgv+q3AuCs25KD/qa1Bo2DJbG9cj2p4DM70xruoJ68K0oqbrz/TZUq+QIOJp4
 6FK/Lgkoib+h0YOgP5xOUpfUEmB4NgjTDo+SITUKqF3hzYS2zM7pV5hGUfyBFuaJ
 yUQ0ijPSdkRHrtOAaI92a7f/8biMqUjyxtAm8PqeT8gl/2BRdlABQS+avQDW0YHm
 75/r3qRW5uRbilEQ5SqmFYDe+Dru/+V+nx3b6OWarw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqtde4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 05:05:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66854exs023111;
 Wed, 8 Jul 2026 05:05:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk61ny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 05:05:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66855KL921693032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 05:05:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 299E058058;
 Wed,  8 Jul 2026 05:05:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC33758059;
 Wed,  8 Jul 2026 05:05:15 +0000 (GMT)
Received: from [9.123.5.126] (unknown [9.123.5.126])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 05:05:15 +0000 (GMT)
Message-ID: <fde3656e-9e22-4e4c-937f-7e8cb918da6b@linux.ibm.com>
Date: Wed, 8 Jul 2026 10:35:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [REGRESSION] drm/amd/display: amdgpu_dm_plane_test.ko fails to build
 due to modpost "too long symbol"
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 george.zhang@amd.com, bhawanpreet.lakha@amd.com,
 LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, broonie@kernel.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0MyBTYWx0ZWRfXx0A8A3/+wMdh
 IGdNB9frgkFd3+ogfITlwXCSCg8smE9KU0aP9Mcz8FYKF5xPV4lXqZZyMP7IXCNQYONZ/FABaxf
 1nxq3j13A8aSGRweRtRFj5gIoTdkFcU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0MyBTYWx0ZWRfXyCO6cjikT03N
 dlETvzl2Esw47FNH6CR8c8CBUNjhM9SvQWqcjy4+e41kug+OFrfYRooP4PnhQwGtFKYoIeMygcK
 bOi3mk3wmrRoKgwKHJGrG2BoQLOf5L5NdKU8Oiy7XNvaCCZtTuUXbYqC6ETvD0XpdtgjtEgKXnE
 DHakvO+emWk6lIpJqwN6zqcxISltPUCuxnDPe9O3uqAOtqzKKTzaf820kGIxAp8qIbuhDdI1E9a
 HpIkqPA4ddiMSvh4peKwzlpJXAJmA7ypMX4pOsZBPkfONaBDjqwn2vXHq4X9MdE19vkGLVmLBYx
 hr5gj6/wHb9Zdl0izx40S5dslC+WRNlPbcbf/+I+tTUACJCuh4nQmCVgGsBdRuLqcmNSQNsIa0T
 YWxRmKo1Mr8s/ISkQ1Ym5kK+rb6rdDkQbfE9mfzwzcxbYe3rsLTck/ESuO2twrwCcqsL4g/cc2y
 EpQ6MlJA6/rlXcFD2iw==
X-Proofpoint-GUID: ECAVD29mq7Ou5idDAiIdvd5zYB28nI21
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4dda91 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=vszvPysokf05iRVejT4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ECAVD29mq7Ou5idDAiIdvd5zYB28nI21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080043
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

Greetings!!!

linux-next is failing to build for me with:

ERROR: modpost: too long symbol
"amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers"
[drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_plane_test.ko]

make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [Makefile:2165: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2

The failure occurs during modpost while building:

drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.ko

This appears to be a regression in the AMD display KUnit test code.

Could someone please take a look?


If you happen to fix this, please add below tag.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.


