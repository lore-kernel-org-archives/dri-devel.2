Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB0606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PQPUleJQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RdATDAVj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB0210E040;
	Wed,  4 Nov 2026 18:42:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2571110E040
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:42:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FiwkU2210825
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 18:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m1RIVWeBY8B50n73Wd85yKIKLlspKFCkWNUkoJLCCpQ=; b=PQPUleJQ5DE+zJDa
 r1qrmeoZsfn5mEdYMbsYPisVPNGB6iF3nvl/qE6Ppw9JDqBzS5jSn10zd7PCWgZ3
 HV+tjzPuJb8lD5QZV7EmiZyHvs9OQsrwCAMVUqlfdCy2JPlLtfl6vK5Qkprnjjqd
 PnFvfqO75CEFUK6S0SvPIdTyUK9vpRNYCLc24J28LdBdXbFPKGLDnmdDDq0Bc35W
 NxeiBqFz7JmDAO4fF3GICvaX7qTEEEUS8WT3npZNnWrrFSswqJe8GzjzRLRrG1+2
 2HdirD2VcEkfWlhagjudB9/u4o1akW0L1/ogSI22a1AnnbHArlmu3BjkuHlGFewj
 +qqlLQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bds4gg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:42:10 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so1200091c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 10:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793817730; x=1794422530;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m1RIVWeBY8B50n73Wd85yKIKLlspKFCkWNUkoJLCCpQ=;
 b=RdATDAVje7VfkHzilNZQ52u3jVgOz2yQbpR5eLthhrQoa88YDUg1T3pVICsnQ/w36L
 AW10NPh+hVPZQBdZZYd1wYODs1X6ylDFechcAF+8wurHqT7Magr98Hyh12Gw9Ha5D8Ae
 uR2EPJQyhvwkQ/PF9BMdoP6u9MymSMx1ifgPRCd3+GC2HFibJFIAyUJZZGulMungSH9h
 X0BeIToxw9CcsUnn3RZWQPTMehiQ1tSSTztLGYRUFQ51Uh2vh7OXq0bv/ixIQWH7p3UF
 vLD7FN9SyCIRlSR+nef/rD7ENsHk+hx7kNMhOKU6/hvxVPDGKtr3SoDyQ6ocn9a+d5Qi
 YxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793817730; x=1794422530;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m1RIVWeBY8B50n73Wd85yKIKLlspKFCkWNUkoJLCCpQ=;
 b=Mx0KQK8THiNqQx0xKPZdDGMYsGUYGQ9K0lflVLgxr4cXTTU1AawH8pM31SNJ/zDuTs
 6ra6+c2zlQX5DN82ckJijLlWFc5Wu5pkKcOp+5d0NSkAOAN+g9YgmCwGChZ0bcVuDh3Q
 UrUdj2ACYAuFM5ZTq27iutIZgBcuOfmjBdcUCYwL8FvK/1CfjRPkbneBSwWTA2pNz1mR
 hbu+Xw7R3Zk/8U0MSOTHHzz1uNiLuyKZKa0bSoxpmLgdGs5WpVPRv3/6WIYrFpHnW0nP
 q+JfdNRXirMu8TGlYbWTZTQ9luWNil2nRNQnGLw4w8YMNZApEJBdqaLPGhOjUyTv/mQK
 SIfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6DE7N4VGgsjB/QrdjhEDM4aAyGkG7GNp9p9LpWLY1uHqvdNF5LSS5AnN8GHh33+dqqgnLq1dUUjA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9syrU/qg13EuToR+76N/0WS18sHg0bZiCBoeIr1QoEZKDiLW0A
 QOAGS6OtPo3Pfw2eIUSwEyrrBD+EP2BdC1d2y90IiDWbWgc8pGMkMAwl/ZZ1m6pQ84Obil2suKi
 DUzidBLy5GkmANHFCDDAz3RJET3gYwKW6I3m0TWfdV6VEOEjK7cYU4RHIAAQC9fj0kiZSMZQ=
X-Gm-Gg: AYBFou3B/KmveII/r1trXW+ylD56EHF5yeV+YU7W0lGFJdAV0GTRMfbjnrMh9i0KFia
 O9LBA0OcJhLrPvdPJ6uz/+JHaKPkdQoOtcQWzxZ22VQhNASvqUbyvg5dtKvzHzwPjkaoeCqgDwe
 gbMRZdJwWYmiZpQahYRTahs9zRRe1aUlic1j3r+cnIJ8dEWBmIpSp+rO2oQOSqQKDsTxmzCheRF
 PbJFhiSU6R836xPHOqjKLPrkZCxzsl+lujWmsZ1NMFytBX2jokOnbLVyXzizKuXV/kiqVNB2h96
 z9kD4nnIlDJEmZfpWbVkmWg3eXT3Km8GzwBVaYzvM9qS4pTKZtI4eU7tuidfv65uvgSMYT8d/Q7
 nXSKXpVOkjmCGjagBMrWbtAjA5WtbKdeOpH7dzpdgL275HqW4mmPq5OkNFpRo3XgxexvSzPDi5d
 zs9BoiyEDC7jBYZ/X0FMG2hQ==
X-Received: by 2002:a05:701b:4510:10b0:1a0:5c85:d1b3 with SMTP id
 a92af1059eb24-1ac5e6f56f3mr22941593c88.43.1793817729578; 
 Wed, 04 Nov 2026 10:42:09 -0800 (PST)
X-Received: by 2002:a05:701b:4510:10b0:1a0:5c85:d1b3 with SMTP id
 a92af1059eb24-1ac5e6f56f3mr22941554c88.43.1793817728919; 
 Wed, 04 Nov 2026 10:42:08 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c6f0dcsm12655577c88.21.2026.11.04.10.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 10:42:08 -0800 (PST)
Message-ID: <a4a95bdd-349f-487e-9ed0-98a70a07ee15@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 11:42:07 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Limit SSIDs to 128 on all generations
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com
References: <20261104182515.3198239-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261104182515.3198239-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfX/WwOJB/NGxCe
 vm0Ui81DkmL9I4FZpHCSMRLmQrsTUj6Ykg2v/sq5BKdBPBcunMTioRW+cliwA4E7trxBcTYdQs6
 qCmUMzrel9QzIAgd/8eMvlT+c3VPGOk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfX7oYY63MLJKIB
 eAr2A7pnKFTGVvDDI5AnAG//7cSBsF1umTHlQN/0hqv54VKQ2Kf5tjRtL4WxpBr9c9RRY50PD5u
 hD7gInXPe0et5g15PeFwQ958oNAvRrjdSXoNJvplt3G8gbBtMP2svSyb2Yrmnv7TS6K27gILZ7T
 YT2j3fNkpja2Ec1AJyTNgIYkgCTuIc5NR8ce/8P678kNnqiGmThcIoZCONJvek86PrwjojrOZlO
 bZ5bUGKQwemvvtJDzkEreoJ1gVh5ToRreqSLHuHHIwL2wVQCaacJkR2UOujQNCaclN2wp/YUlbP
 pBJJjFFJTFhZZpCa3MqcpeXWjf8EiQ6CSP6EH1ZIfM2DIpDwgh36DkMwsSrUYGz9++SBMt1Sylr
 jAjRAITK8wOTfGxE2ZwYXOkohpTu8+g2NlK3k3FyRMEBbA21rK/Y3U7SToPKQKZDv5Qy2EakGwI
 RFUd47QWdGiHVjoyyvw==
X-Proofpoint-ORIG-GUID: Yn3AYyBpwbEf76E1FvAj7Jn4XsJEdi16
X-Authority-Analysis: v=2.4 cv=D4XSufRj c=1 sm=1 tr=0 ts=6aeb7c82 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=6didAhVeQ5dk4BhKmsUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: Yn3AYyBpwbEf76E1FvAj7Jn4XsJEdi16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040074
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

On 11/4/2026 11:25 AM, Karol Wachowski wrote:
> Some generations support only 128 SSIDs, while the KMD configured 256
> CD table entries and allowed user contexts up to SSID 130. Align the
> limit across all generations.
> 
> Limit the CD table to 128 entries and the user SSID range to 2-127, so
> root can create 126 contexts and non-root users 64. Also fix the off by
> one SSID bounds checks against the CD table size.
> 
> Before this patch the driver allowed 128 user contexts. Now the limit
> is 128 SSIDs in total, which leaves 126 user contexts, so the only cost
> is 2 contexts for root. Non-root users keep 64. In return the SSID
> range, the CD table size and the bounds checks all match, testing gets
> simpler because exact limits can be checked instead of loose minimums,
> and the userspace interface is consistent with the same limits on all
> generations.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
