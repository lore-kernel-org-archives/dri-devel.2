Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DF210F285F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191B710E082;
	Fri, 27 Mar 2026 17:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJyTmmYa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ic3Ehwgf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1DC10E082
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:23:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RDhhr12769894
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 veP/AcaZJqvwTGjl78Yki2Fb/VKChVz/2Shqnw88esQ=; b=PJyTmmYaHO8YvRjV
 EXqljG7SwMrM61ol95ODV/0upNI+nHCCB0N4MCYxPvrcZcp4+T+eYCWoRktndHq/
 VFvkb5QBdAcAsh+2V8v56hqSUl0S0H2u5tcWdwL70Tpf+ksLvE+UEA4jpTfzcu9h
 sZL/XMmuQJysz2WYr4uhJHvz1c8OPa2hh5POGesZUGWD+f4iFeTt4Nrw+dJz4Lvz
 x2rCeeF0M5meAXnEUwQxiQZZfUUfZtzGAKvVV/n1p4Jiq0AaZxQUO4dQ2TQ3ZOar
 3D2K7p900tmnTyBGZLWBFd3PjOXfXj4REs52W6YhbI8sYrmgtcdArPWYOIQEA2fo
 0G74IQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv41n8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:23:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c189594f54so4135279eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774632225; x=1775237025;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=veP/AcaZJqvwTGjl78Yki2Fb/VKChVz/2Shqnw88esQ=;
 b=ic3EhwgfTUjkZT9B7T1djyMUSMd6LWpwK4nRpEyyEBDDtX+7Dl+KNmzvF1zEhpq23n
 Ml0QbBiQyjfUr1vaPH+8eX0RekcqK1MqatqDCnUfaGhcgmQvdqNG/Vd331j72BFH0vU1
 8jrvhqwSSG1wxbAfJGRKjhsKrprMMTfDXeDB+uR/9+IZOX69ZwQja5pCpeVFSFyYzkE2
 arPQ28Nb7HLL/TGs4BHMI53oM3hl/XiBqIA2nv6EFex9FrsUPQHKYGacdYA028wF/hoE
 2BS3biZbbR84ZunDKox4qc2tFD3wSNxyMVxihW3QT2U7GTwjrB8/loOZaWtOsMwRD4zq
 er+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774632225; x=1775237025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=veP/AcaZJqvwTGjl78Yki2Fb/VKChVz/2Shqnw88esQ=;
 b=IZa4iKZnCNR46WfIVjf/7W728CmBVYx2QbjPW0PwK2qIb4b7Z3Yx7vyN1HQwvdLSoo
 bt0IsN+n+VKusiyAeMDgT4yDS8zcFZur89lzLLTcTGf2CsDTj7osACsjpb/JmPIIAvbG
 /lWi3S9NnUQX8QSBh++ja4sm56INSDnASpI2I1Z49cv2Dy3CTtZFtQcBnVmZHUJc8MJk
 sU3syc0ZOKLqftlBbA/mGsaFvSsvhf2WYajsqk05mrr1RNt3XtruT7CDMs9kw1507885
 p8tV66yra/76k1vLoQK9/dcoW+2AJ76G80nSvIzCq/b4R7ibSe/pBVKH345cx3viM3fX
 w8/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2oSeJKQczJeUlTBrWqF4s1hhFvl8O1MSbOA2iKHzabZO2y8EaNYnUbEiGpfnfTZGm4kSvlE5ZiYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyasGO4G2P7OSou79PV+5tsRBu1kOCEQzzFxbRIy6oqn8O+D7qk
 THYC7zH9J6wnViqwn/1AVgBTVY6x105VPmBoWGc5OqLBCw41NSQhQqUR/30Y3ZcKkGANeMDPRjX
 P4Jdo6OI6Qti3KVlp+OKzKusf6wnHhzbP3MPWwhG0/jcoNMIfNeF5ekpg+w04rj/s0DX0qKk=
X-Gm-Gg: ATEYQzyn2UDldJ/R3hJ4YVogiHDsobq6pWVOvIQY7QiHMkq+BF/Y0fClKlAkdETXWXJ
 /J8mp9BDfdwBPWs8MtlsV7CyYXGaoGtOhLHVyJ4y3fuGgNEDRs53BZkU6xDFpiwbxQGIGtbGIKn
 EVutDJ7dRgWDp0kHKE7Q8cFykkyjTG3ctmIzYuYJYRZIvzFQJuTQGz/iuGQUC4JYw9bJh5vedlC
 CI7ZtsryCCtjq7MFj5jcnhP+RiobEsmClBTr6iShLdxHY+IDQ/+gs/MN46/e9dj37S3qPVTe2kw
 oUEQJDZmuxoETkbmlQYIpz/EQE5vFhLVpVgSeQTnb/wjKJrSi1TuxnT7/fDiLiJP2UIyPNR7uOh
 Fh9fjXjuNDm2pq+EPVRto3kUb3bx8uCtqBoPVOnASzjQMZqWBaJy06ZqGj/CCxySATYj/eErnsi
 Q=
X-Received: by 2002:a05:7300:6da4:b0:2bf:1eaf:995c with SMTP id
 5a478bee46e88-2c185dfe422mr1792451eec.17.1774632225061; 
 Fri, 27 Mar 2026 10:23:45 -0700 (PDT)
X-Received: by 2002:a05:7300:6da4:b0:2bf:1eaf:995c with SMTP id
 5a478bee46e88-2c185dfe422mr1792435eec.17.1774632224491; 
 Fri, 27 Mar 2026 10:23:44 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16edc0436sm5589779eec.22.2026.03.27.10.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 10:23:44 -0700 (PDT)
Message-ID: <39c164d7-5d9d-41a8-8d3e-e209317ca7c2@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 11:23:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Simplify bootlog line handling
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20251223170226.2275812-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251223170226.2275812-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c6bd21 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ZUs9zOJhT6POFn0piIgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: aL_pHPspwuUjq_d2P5vW8D7TuPsKkyig
X-Proofpoint-GUID: aL_pHPspwuUjq_d2P5vW8D7TuPsKkyig
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEyMCBTYWx0ZWRfX+aWeq0FxOu19
 h1Zrd4w0Ser8Ez7A1zOKlNVu5f2JjImE1C18e5uaCFpPwrybQFO2iDjmOe1Vhv+1bJHbzRp5tDo
 an0361UUZb3wNNIAONna+fOz6cbn2Q58YSMl9cR/3YLe7k75kobr1VJVUK3W9CDlm0Zv5z9qEH8
 AqjucqgjbYhajMr7mw5cJSmr1UW11ayuSThI7YWllEjvYSgRDFKHSx0YlqBnuP1Kxl9JEgP7+BB
 8D816IwDlmhIlXQXTmMC7h9C70nAdBq+Nil3hOj8awgyOvDrZYjtf1ut5XTazoKPCWAlMV31pdu
 zR+pKpRzg9I+mtQ/JpTOXKlQNfCqqidrs2rgg7xYwF/ac0ciudFt699L43/zKWSDY5oiERQ3UJA
 ZNf3qo5cCR6zo/RnS9YAJfxeLma4zDVDo0ZVWQbl3xpkCd4dx9fus1gDTfw0ED4fOmNmSxXEk+6
 58DyAXkCoH2w18iGBrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270120
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

On 12/23/2025 10:02 AM, Youssef Samir wrote:
> From: Troy Hanson <thanson@qti.qualcomm.com>
> 
> Instead of storing and emitting bootlogs as individual null-terminated
> lines, concatenate them, and later emit them to debugfs in a single call.
> 
> Do not insert a null terminator on messages received from the device.
> Instead use the message length when subsequently storing the message.
> 
> Exclude trailing nulls to normalize AIC100 and AIC200 bootlog lines.
> 
> Signed-off-by: Troy Hanson <thanson@qti.qualcomm.com>
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Pushed to drm-misc-next.

-Jeff
