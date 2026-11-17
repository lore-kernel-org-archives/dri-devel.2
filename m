Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB945606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nuf+3lpz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UXXgwFdq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E29710E4EE;
	Tue, 17 Nov 2026 20:52:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B99F10E4EE
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:52:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHKfXnu1627439
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fyuxCpKp26itAp4jBe23EHobgug2KOZQvZvYqOY5OLI=; b=nuf+3lpzUGHLeYQq
 51pBS/GTWnGLUpcbweZqsJi9gQmwQjFtSiCb0tE4k5r16lTD+G6KgFYzBJtPN1Py
 siIy8UNPVpwqAICA7j5MBNDOcTzalNlyGLC6shwyZBl2XDrLGL/nxJg/3AmNgRVN
 oJUJOihy62qtzdg7TzrY+UX6yI1mvc+kiVmo/tSOfYfseiGnsviuQoluX3zKaYyi
 v6NgeFm6LgWTvjvRtjzQkzYwYJ7hBsv0ZlYBPfVpolXGq1Oexb4lWbWUU418Vyqy
 4w2cQlyztqV6p3g1u6FqW9J3J5FpRbyD4Xl+DqzwnP9dIg8LZR6LOpooABYnooEu
 EJ8hnQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0qms21te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:52:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so345371eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794948736; x=1795553536;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fyuxCpKp26itAp4jBe23EHobgug2KOZQvZvYqOY5OLI=;
 b=UXXgwFdquLsM7sog9ARyNtYfQTAGO6ewWv0ATVm81aKcghK1Equ/qB/8GicqWRrJK1
 a/95H1JNnoQll5H7usKy5vk1gbOi37cYW8aB03yyiMPfiRiLvC4Xl1MleIY5NaAb43D0
 TUqcsMYxk9X3ZW00iK56mHFDD4JwsKSvPZO3DScZJyjAxJEb6nVSAw6q7T1RrWI13iHU
 gkgm11MnMLuLjbeDWePWbEfVrB5F2RNXIZ38vQjixDUB0oPAWUvtJOVlGtm6aQgxjunw
 B77f0No1FNWDfokGRG8YnmX5xTQSMYfvuCS1tSBJ0iajdRjP7fVk0Ft3odzvopDvb1JR
 oMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794948736; x=1795553536;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fyuxCpKp26itAp4jBe23EHobgug2KOZQvZvYqOY5OLI=;
 b=QrNOe9vQ+OgTnZPMlq4QfXdyjkKIO3tCxyuUjzu/vDdRjqiC1NUucujVrM7Pj7fEZ5
 VkTYZRI30xfGu4IGCQBj1IJqid2F9XtMZvlUyclaMyETtOejrT12b7JsxFsx5RPXDc49
 K8iTi7DEpuhrrvS4fcceIU8SzpWHBZYf0056yJPcna2b3g3xbQzwdZ9ljDybuyF/LCgf
 pTo2iuxHUXPSl3oOrdjp0F4Bc9Q9v+2VRZQEy/CjsjYaoI5izoD3Srv2YuSt11P4yqtF
 bQmz0itAKp/Kh29oJeHWimS/zl32xb/es+3XnCyBOo7f3j79XFwbmXFsdlmucLkd3xSV
 GrmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGA4yU/+HPCn35zMmTeFiZgvjuOEI8aaBqooys0ojwQ2puGMc0juaEccfkpX1lm0zCp+K+MdzmFE1c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z88cZrcbFfLx5OLFM8WDqJ8d3WfvkhjV2RMp19GEB4iUfaiVWDn
 8GBcq+pS/gRRz6NaWkkboOJ9tYZGxUg0jGdo1eIvBfqvWutrJxV+PUFQQfAqBfCYmKGTzQn7tw6
 OpYFIcjcynuY0028eTUEsr2YvRROiczF7dRczm+GGWGbzbtijGZy4aFWq2RUZnXWndVnv7RY=
X-Gm-Gg: AZFdTZeS6J+2hWjUT/6G9/tIySWef8ZH7/MsGq3tf/IUKhF4VkxXZWCsQhNWQSw/6Yt
 VjQWyvrhCMUWLRE4qfzmYL8qq20r/vb6TRUW/jiDfHCet3AS5U7298+ijB/pZEvOSEn14NxW1/W
 Y4UrK6WONZQ3Dx8iQ+oonAm0XqaLnlfkvpabDFy4ZsrCYMYupRh1ZlIlyOpA0YIw5rSXwjOV0EE
 +t8LpQ37W/o9t2n0x7T9/wo0CierWHL4NykV8ZarTNFEQDRZ5Y1kBvDXBE4/MkeIjCK3w4F18Nr
 DruW6BeuM+qhB/pUNA8t6ozy7RRqqps1y3NHeuVDvTDmw8V8ZSVNCb/7/WybQSUm5khn7UGo49V
 DgBVHEIV40fwyyWIt+sqP4B6AV+xnlbeboz5lmuA13B4MrlPNwTw8IZ89/ldJgWp6hOayP/85H0
 sL0fOE/0ycNU0fCz1OIgauAAk=
X-Received: by 2002:a05:7300:7314:b0:381:1580:cb4c with SMTP id
 5a478bee46e88-38281023cfemr702066eec.24.1794948735896; 
 Tue, 17 Nov 2026 12:52:15 -0800 (PST)
X-Received: by 2002:a05:7300:7314:b0:381:1580:cb4c with SMTP id
 5a478bee46e88-38281023cfemr702042eec.24.1794948735366; 
 Tue, 17 Nov 2026 12:52:15 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a76d70fasm484255eec.22.2026.11.17.12.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 12:52:15 -0800 (PST)
Message-ID: <2f3d94d3-1f9d-4a88-b500-ce42ff85949d@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 13:52:14 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Remove sched_mode module parameter
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 dawid.osuchowski@linux.intel.com
References: <20261117204419.2841928-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261117204419.2841928-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4MyBTYWx0ZWRfX1RziIQCqBSjH
 v3CisOhMiNWiVJtN3NgaMz2BkOIjyi/8QGEVScCWXlEQl8pMovHA3vvIsSvwO53urygxyMm0UPr
 KSUoME3m2OpvuGYddbEGHpHiRnSdEE8=
X-Proofpoint-ORIG-GUID: t0ygGNgaKd9FE4mK6NDHM-_BSM2u1OFf
X-Proofpoint-GUID: t0ygGNgaKd9FE4mK6NDHM-_BSM2u1OFf
X-Authority-Analysis: v=2.4 cv=BIEmP1QG c=1 sm=1 tr=0 ts=6afcbe80 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=gYI55yF0lsxZyhDyjH8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4MyBTYWx0ZWRfX5NIds8W7IMAP
 nRd60r3dvITcUXXmvMgC7Lf8Vb+nHL+rrJKiXoqo5JStP/NesdEE1dV7Z7/C3qC3KdPlpgINfp1
 wQRqwEfM7Xhdj88PQ4AORw1XDSHEonu1o0flpZOto7OqkGvso1jHAt5xc1exgVLBjUDhoHpDeEu
 HgCeeKqGFm1kB/5JQdcVj6290phQ6e87n4YdPOpDDvvk5Ln069cADVfhyF+9e4tGn92d/xa8nC/
 kelqkV/c/JXDDtL33AqaDIF7EJ0vyDk82467rJH6p5NYAe3PcpLYqB9t1sgKsCSbYtDVCBjlHHd
 9jo8406FJWOC6w+CmwO4RncwXn1ZIVUPOkze63G+Y4CtUqLfStDMz92K66MNS0gDvwARA6dkrvk
 HbGK548WnEe8NtQL+O1Rsf3Yn2bRMnG74iLR+EeZIUtwEismtAI1+iT0Uw3T3qOIIpYN9YDjVkd
 d0TMv9OmaE8dwFn3sEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170083
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/2026 1:44 PM, Andrzej Kacprowski wrote:
> OS scheduling supports only a limited subset of NPU functionality and
> is not intended for production use. However, the sched_mode module
> parameter exposes it as a regular configuration option, and the driver
> silently falls back to it when the firmware JSM API is older than 3.24.
> 
> Make hardware scheduling the only production mode:
> - remove the sched_mode module parameter,
> - require BOOT API 3.17 and JSM API 3.24 or newer, and fail probe with
>    a message requesting a firmware update otherwise,
> - allow OS scheduling on pre-60XX devices only through the
>    IVPU_TEST_MODE_HWS_DISABLE test_mode bit, for debugging.
> 
> The initial 37xx and 40xx firmware added to linux-firmware in March 2025
> reports BOOT and JSM APIs 3.27, meeting both minimum requirements.
> 
> Extend IVPU_FW_CHECK_API_COMPAT() to accept minimum major and minor
> versions so both API requirements can be checked explicitly.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
