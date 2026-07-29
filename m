Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A5AC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128E410E095;
	Wed, 29 Jul 2026 20:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Od9m5I16";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nu3Xbb5L";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1885810E095
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 20:52:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TKQp6p3334547
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 20:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 critbA2mnXZKO3iDwpU36SfNN90IioeFvggdcTePRqw=; b=Od9m5I16gMZP8va2
 BWOWBBeX1lTjGgULKVTorUrJorHn+qPo+FYF/S/1+i/dj2Bbo3tWt25xVkxNL0o1
 gDNqIeP4VbGOCiKkIe/PGHJx1G8XZYA//FnSTyWc/9hpJ5suiuURaW8t/EFBz9EW
 w7V8a2qhpB1UzwDPwENGla9fbqNUEK35VxharlBmcjLXQv5NQvXJ5l4A4zeLopJf
 dW52PZKEBORHRQZzF7mzyqrus3HGeMVrFU+nQeF813oWza/bQlF8NmTx61Qvnyll
 KCjCG02TeBTe8L2UIF3p2gW30KuAFWeRywK4jzIWCf1ZYCqtLcxGiN2Nt71Yi41p
 KfH8Nw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqrjfg2t6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 20:52:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-848662cd2a1so1567276b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785358373; x=1785963173;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=critbA2mnXZKO3iDwpU36SfNN90IioeFvggdcTePRqw=;
 b=Nu3Xbb5LJE7qjZOgdPZjthzaPFF14xi+E3gCS4l+4koRurqMBTwsZWYS3vTFoLawYj
 j7UEwa5//YoLiOo3S86a8X+YA6z+Cn7AUG/10357wBpxHYgO8J0G8TiPiw399nxgkVcl
 9i5P4lkRKx+pChBx32L2WUxVCfrdLSEMY8pjRgxozj/tNUq18B+xb1FuYsHPSrn7gfeV
 ycnX8uPFKGRSWouHrDoiQ0jWF9PgdKWJJY6/pkGTvZ9J+A8EqC+GYdkY0cY0dD200Ri+
 s/2pin/3nPF3xiOHMrLeGm6S53MHYUrxvLpQH86KnmMbXY+5/4B7ILbR/lWqk4ZwSqTz
 OtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785358373; x=1785963173;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=critbA2mnXZKO3iDwpU36SfNN90IioeFvggdcTePRqw=;
 b=GaRcqIjKlhIMou6RSO9XxERBnarmHxcP5ZYKBYk8RRHBYgl3fWW0MhgGPkJp15o4pj
 wJR1x8QOf9DoagT52Dw6fPyEswFNWIQklBf9a1UpFvZNzUE4t0B/X/BS3hqU/bNs5gam
 bCDMlgSXALKnRltDvthRi/1sNMHZL6MsPW9pne/NJSpA4RSJLH6Cym5GZtb+HA8ppTaA
 Ez/nmTQ7X7B+KG8eTxUkt2nuEQUChrA+/LkrNIpcUkbVU7Y2qpWbbm3IVxLNxJynL7fX
 ioJcnY+4OxK3LkqQTokxg7wY1yjTwHB6j9bJL6BVo6blAdOPy9F4PMZjV4n3HLJmB+lF
 58zg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2rmJ1G8SW6CEm/8BWEmyhYBtP/apeVYbO4HL0JXXmzaTc43m3Pet9VwJgZZVN0hv5DI2kFIrvo0c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYx7+f5a8hEiwyPkdQUB3QWCjd4yB+hZPSsSzRSQlyVCp+s+3Q
 yPNh1M0Ge5pi4OzOhmETs8PHF2PU+DgWKkORoxUMSdCWxisrkqLj0/Sm0Z1uyEET8cPgUZWixId
 pkwGpn8M7CKF+zkpKqBL3E0pXusriVQcqoVUx2jbQajPNSnO6srGf0ygusV+UL0F7Dv0E9+UgqL
 gO8Jc=
X-Gm-Gg: AR+sD11g8Pqp96STYSv+QRRApOwmzzzCRj7YodxqocovAlNoVo+UnIrhgGz4GAS67OE
 aYXKPWJV8aYWiZcXeVZDg69CtCTQStkcoN2HXeOu8uqtzk/WhmsKfCRjjedgpZ/Or7L6h+NBmS0
 0qKN53DRbLJT/wwm2ceyngFO/ZyJoD0y8eyu0w3CoOYBlzSbG+G5/bbWMFZL5vs2/WK6n7/EGwv
 HIUThGSYdZMb4jAeOFJvjO13JTUEGEx3jEOuR0w86AupKY0p15T5xKuqHpRaGBRq9PvAHhPnWXM
 VGCfDHyWi3f0dUDb8d4USlPZOl0mfKzXVuNCQbuY0qhxbEIWXy7qraOTCALs4Z6PdZiEX6a2INy
 8Z0OAGOG+nLGB1otQ8YtJ7EblSPbWPWOePvZdmOjM1BAzolx2+DNeOw==
X-Received: by 2002:a05:6a20:6a0e:b0:3c3:6544:6083 with SMTP id
 adf61e73a8af0-3c89cadcdbbmr9304005637.0.1785358373361; 
 Wed, 29 Jul 2026 13:52:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0e:b0:3c3:6544:6083 with SMTP id
 adf61e73a8af0-3c89cadcdbbmr9303973637.0.1785358372886; 
 Wed, 29 Jul 2026 13:52:52 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b10cdcsm13512172eec.3.2026.07.29.13.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 13:52:52 -0700 (PDT)
Message-ID: <187d7b00-748c-4056-aec6-b498044fe1c7@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:52:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: use sizeof(*trans_hdr) for transaction length
 check
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: carl.vanderlip@oss.qualcomm.com, ogabbay@kernel.org,
 dan.carpenter@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260617212520.59801-1-meatuni001@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260617212520.59801-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1OCBTYWx0ZWRfX+mvAod2X0/nv
 FiJDlAinuwwYuHdyrZ06fbqOM4FQNb9P5INwy+2p87QCk7dIRKoPVL1NiKGQUDfeV39SsL72gY+
 +8PcHaBppaOVu5No7ikEAMG6ylo919g=
X-Authority-Analysis: v=2.4 cv=Y5DIdBeN c=1 sm=1 tr=0 ts=6a6a6826 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GD8_rapH8p4utXL01xcA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 584Adqhp68HoXeG-fg4Lh-x1zM_gJsjm
X-Proofpoint-GUID: 584Adqhp68HoXeG-fg4Lh-x1zM_gJsjm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1OCBTYWx0ZWRfX83mzvQAVrcNY
 hjXciba3qKwMcy6eczowL5QiBBJSSPHtQDfuKaa5g4B8EELgKKjamwHe/uqeplyopbYS499B4lF
 S+SOeCl9fhyqElJSRhGoUMp88vAyFhfnHzLIgmu5/pmIYt0dlYHV915fV2EFn9cQFqTG+wcSKMe
 aPg+amDITTXcKXdJgoX8dlOdR0dqtuXgWi/JuWyZscvXr0wICzGcUkfx9SACETomAgYV8onLLIq
 XsfyopjR9YKmg/9HgUCEsn6rCILJ5o3xLidFAfUVMdiG+MVFFGzfdpmUr0MW/yNEHqNBgU89soi
 mGHl/kjlW9Z21lOkP/kaIiMZbxEXzcJBkU0s333MKLugZ8NGir0Yna3m9jNalJaiA3GtCk/57Av
 FVgY7FhZ1apl52Ga3oC/ykfINrsj1aKoEnlTlzMQlxZO0ca7eoSes2qSJ3dCz/g6SvB3ZsupSOL
 HMx8/ImXf0tDExdn7+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290158
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

On 6/17/2026 3:25 PM, Muhammad Bilal wrote:
> In encode_message() the per-transaction lower-bound check compares
> trans_hdr->len against sizeof(trans_hdr), i.e. the size of the pointer,
> instead of sizeof(*trans_hdr), the size of struct qaic_manage_trans_hdr.
> 
> Every other length check in this file (encode_message() at the loop
> guard, decode_message(), etc.) correctly uses sizeof(*trans_hdr), so
> this is an inconsistency. On 64-bit builds the pointer and the struct
> are both 8 bytes, so the check is correct by coincidence and there is
> no behavioural change. On 32-bit builds the pointer is 4 bytes, which
> weakens the minimum-length check below the 8-byte header size.
> 
> Use sizeof(*trans_hdr) so the check validates against the actual
> transaction header size on all builds.
> 
> Fixes: ea33cb6fc278 ("accel/qaic: tighten bounds checking in encode_message()")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
