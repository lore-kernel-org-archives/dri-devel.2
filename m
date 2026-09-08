Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652C9C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A28CC10EBE1;
	Tue,  8 Sep 2026 13:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5FKPAsd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z31wToIr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9426910EBC9
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:07:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Cktvh2507122
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 13:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZV77+/smsI+gdJupmOVtQAyP43QJBNhzN5UmBhSrlAI=; b=k5FKPAsd6sxjew1o
 TyrZyh6W+xE8M/jepasvvwUreM6iAqi64zZpc9rA1ZFk3xUxEd7IH03Y9lhOvBKy
 pCeNO83pqQgl16eOeXS4tp4khXnHyoKDWN9af9fzp6NR8PWr1J8G3or9KM6lhUYh
 2TkeHxrBS2AB8RMYFP/i2qUzSPXpSYpje09cT+RunbguCfAnUS+PddanwPboST7P
 dGQGHzdQsIIaD090Z7cvmsydQDNEELySncJZW3P21Gs6OW2uRmDzH+UcdlngpRqU
 TKgmXzuo8oYmsbr/VIW1EMuTD078efQgc9xkjiuDQ/MgpXQ5So4zDSO/tF1HMg6Y
 xjSIPA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcvuhmeu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 13:07:44 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4bb359e69e8so15677b6e.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788872864; x=1789477664;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZV77+/smsI+gdJupmOVtQAyP43QJBNhzN5UmBhSrlAI=;
 b=Z31wToIrmdlPIGibiBa9FCbgbEQnJW01UMaZF/dXrP408Rhrm1rX6GbqM2XkTVkABm
 91XCAxkp8xISWsnlwbz1WV4uqUb65BMv5sKLhvbIcWveAA86tCVLk6/TzGjo+ncCGWUN
 m1OsmZe/vqUxRWazdZ/7+Vo6ZPFD0XhSWaj1+rb+DvinVRV4Bw79zfb0fHA+tR/ZUrft
 8Up4zOLmfAIP4tnjtkIan9WNgZnO28ITdljXRNiby0qg47QSR0CxqAe4M+hsXnGZpx2V
 YFPKHaiEUKVq87zigxvlMExLxI7JDt2rh/L9yIiUDEatA4jjtDZCIeolnwEUty8xXA+l
 iwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788872864; x=1789477664;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZV77+/smsI+gdJupmOVtQAyP43QJBNhzN5UmBhSrlAI=;
 b=jVcn5AdaT4J8/LTsB5dv4Gj/USws9A3bV23jPgO1CEn/RlNN/EJ+B6KQXd6aqtIFmO
 a2r9HAIHRtcmNRmamSoeiBLzs/wrpz1tiCuFfk04JF/9nc9wEwDEIFYudpcSBuqCy7w1
 661OodW864q3cRgxCapxDwgWQ/VaT9GOhrHkHXlqDPpzLd8WoNX/jL/o395aTcsRuupj
 3yi90NJ6JMsV+azbNF93oKuRyJrxFn9z2mygbZKtKYGXF1Qkcgx0rluG7AXIe47+S/hz
 R3jCrTkHfdeN92kWI+D9A+EKa6F2AEZDfFdBz6c9iznZUUHt7iXBGnqMvNdeulGFcdnp
 R4BA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRczKRAsvgul44CWX4tgNt1fhZ9g7qO5d1ZW4I+0esQvD0M56dGWyPaz9LBavM/cmFLqqelz4PL1A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nx3R/YYCgv5yXtK+TtO8rlfLiKhHqqdGky5/DhYJyRX8fiwPUW
 vhjzeg0rjtrX7p95BgFt5w8pKoEKGHNZIvAk62YuiXcx2XUu4axVPYK2/Sv4KidEoNWWSNZr3b7
 Ui0g9gmmxfyaL0VarhN31vcyy3eocYPPyUv1A3U3S4cQnmCf1lrRcp1CRz00jYH4qU0RndWg=
X-Gm-Gg: AYBFou3GGArk0pL57tYxHFqhGiglcEE5Jxv9sZ1EBQGmI24shSBGrobCQJRmURIkURF
 i5B8rXaPZS2ojWWroDye2kmbPRAS+0merxPeP2F6shlRrQJaUjckLqyCZHGkEi9VQvu2OYbP0MQ
 Zg6U3KimRUfaWqC0Gb3/ksqwM5QAQCeHyOMElF/164ZBWW1b7/P1a0Ee+8zcxiLyxIOZFOuLfRp
 Q+D70FG0Uo+PYoJBnI690/lJaSI3H1d9iYdGqjboRE2+2JAsAdQkmpOHLJg0FArXMSh4Zzfkg9x
 yngJT+yz6qbz5taDEPb5s3W/CKf1/nFpsm2n1UVGUpUzsQHMGfoRc7VqWiKyGH31bcUDq6jQlwJ
 REDWUXGQvhiepIIbXWdPj/g==
X-Received: by 2002:a05:6808:1a04:b0:4b5:83f8:781b with SMTP id
 5614622812f47-4b96e274706mr12677349b6e.6.1788872864088; 
 Tue, 08 Sep 2026 06:07:44 -0700 (PDT)
X-Received: by 2002:a05:6808:1a04:b0:4b5:83f8:781b with SMTP id
 5614622812f47-4b96e274706mr12677301b6e.6.1788872863450; 
 Tue, 08 Sep 2026 06:07:43 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5773c5sm615362266b.40.2026.09.08.06.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 06:07:42 -0700 (PDT)
Message-ID: <22bfce83-a438-4d40-937a-f82709987bdd@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 15:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/msm: unrecoverable a8xx hang-recovery loop on Glymur ("cx
 gdsc didn't collapse"); killing the offending client does not stop the loop
To: rob.clark@oss.qualcomm.com, Greg Ociepka <greg@ferrisoft.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20260820154428.1278@ferrisoft.com>
 <30d4a7b4-1f1b-4589-b132-2115cab98b71@oss.qualcomm.com>
 <20260905085428.reply-a8xx-fmax@ferrisoft.com>
 <CACSVV02JMXbUWYGtAv8Tiq5EoAi00KYyfdBUfDGzuETu=rS9GA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV02JMXbUWYGtAv8Tiq5EoAi00KYyfdBUfDGzuETu=rS9GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ePkjSnp1 c=1 sm=1 tr=0 ts=6aa008a0 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=zXLAmZJP3ypUEzgl:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=a8UEx8NLAAAA:8 a=2z1urA-kA-BrcP7p-FsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=-yeuc7zBjbfZT8aiaP-D:22
X-Proofpoint-GUID: -6A0rmR50cbAxuBi-jz2hjbzpyxDD138
X-Proofpoint-ORIG-GUID: -6A0rmR50cbAxuBi-jz2hjbzpyxDD138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0MCBTYWx0ZWRfX/XvgmZ+ctlSG
 R1pQnJiSRQNfiY3hF9kNDTLRlz7CGUk1uRu6J9mMGcl+NIqxTpqiAuKSEmqd3SgX0kh4Ky2RF5N
 O7urT45Ye3u4Hbf5VIPj/kjrSwKuq8iUCejhq47E1SV8wMS4S6YtO+gK5s99erVOvaiWcvqjADB
 mHHsEuxM7mIgweulevA84lwNjgsembea5Q3C1pWrwKS6Hi6nL1g7Bwj31f+o2ueaZVBQBdVtpkl
 k+AGACUnY8fcE4XLK5HRWeTXNwIpO5OnyyjX2v2TNfBrG7DrNCy//Bm0L3EaS9R7jpTbHNaCOkq
 YiqNttInkfIa032sOzX4M5SUjylSAdhQk1aiHAScVmTkpqqkdaGMI8S7RfWrwaXPEHZhMI4aJmD
 LhXysL2NFsPdlvcKy41uDlZ69z07Bmf6pLBY53DNT4PSZmDESrhgo+dyQT53qdRWB2U9G1VFn00
 V98TOnGcO4MJbxJaCVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0MCBTYWx0ZWRfX+vDUkzwOn19I
 O3XOF4OtghZ8pM9xe0ZWjWbClR0aZe3ZRSdRb4Hdx6qSU9yYowsSz+rKwkJuG4Q/tL0SMpOGL0q
 HIlZucN49SE9MdoOx2mukcEbRa4qtfk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080140
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

On 9/7/26 6:33 PM, Rob Clark wrote:
> On Fri, Sep 4, 2026 at 11:54 PM Greg Ociepka <greg@ferrisoft.com> wrote:
>>
>> On Fri, 4 Sep 2026 04:29:16 +0530, Akhil P Oommen wrote:
>>> On 8/20/2026 7:14 PM, Greg Ociepka wrote:
>> [...]
>>>> We are happy to test patches, run instrumented builds, and provide
>>>> full journals or devcoredumps - the machine reproduces this every
>>>> couple of days under normal desktop use.

[...]

> Fwiw, I've started to see something similar, which seems to start with:
> 
> Sep 07 09:19:07 shady kernel: platform 3d6c000.gmu:
> [drm:a6xx_gmu_start [msm]] *ERROR* GMU firmware initialization timed
> out
> Sep 07 09:19:07 shady kernel: platform 3d6c000.gmu:
> [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set
> GPU_SET: 0x8000
> Sep 07 09:19:07 shady kernel: platform 3d6c000.gmu:
> [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set
> GPU_SET: 0x8000
> Sep 07 09:19:07 shady kernel: platform 3d6c000.gmu:
> [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set
> GPU_SET: 0x8000
> Sep 07 09:19:10 shady audit[236335]: AUDIT1123 pid=236335 uid=1000
> auid=1000 ses=3
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> msg='cwd="/home/robclark/Downloads/deleteme/darktable-bench"
> cmd="true" exe="/usr/bin/sudo" terminal=pts/3 res=failed'
> Sep 07 09:19:10 shady sudo[236335]: robclark : a password is required
> ; TTY=pts/3 ; PWD=/home/robclark/Downloads/deleteme/darktable-bench ;
> USER=root ; COMMAND=/usr/sbin/true
> Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
> [drm:hangcheck_handler [msm]] *ERROR* 44070041: hangcheck detected gpu
> lockup rb 0!
> Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
> [drm:hangcheck_handler [msm]] *ERROR* 44070041:     completed fence:
> 581164
> Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
> [drm:hangcheck_handler [msm]] *ERROR* 44070041:     submitted fence:
> 581167
> Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
> [drm:recover_worker [msm]] *ERROR* 44070041: hangcheck recover!
> Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
> [drm:recover_worker [msm]] *ERROR* 44070041: offending task:
> gnome-shell (/usr/bin/gnome-shell --mode=user)
> 
> In particular, "GMU firmware initialization timed out"

I'm surprised the GPU accepts submissions if that happens, it definitely
shouldn't given it's clear it's not going to be powered up

Konrad
