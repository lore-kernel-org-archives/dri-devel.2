Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880B8CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A80CE10F077;
	Tue, 29 Sep 2026 19:26:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PY0bdX05";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O7DTy/f7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7491110E1E4
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 19:26:26 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THn9l5858077
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 19:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jcggai5cj02Q8AdG/I+0wRNZv2kOWaf+kgficKkoXVk=; b=PY0bdX05WUzvsHGf
 8RoMNUa8YwOF8uE3TT0Erj/VBvtbs0q0z411V5NjMcnbxdaWhUC8tiqOiQqD8xJv
 l4CYB0IF833ujdxwP6hA18mteyjrB6ZrtNf3+KUVsuLVvJZQSCddqHSZKwzxlCRi
 u+XOosmyZbCFUrYD9PGm5Hs/QJnQTjMC+fJFw3iySOGwkcot7G3GomBJqWImVyGD
 HvVRbbzGYlC2n+MBWLs32bH075tYlmDBQN39VPViFHidhy0i2AwiBXYsO5CpRPdF
 V+LPpHvI/Rk+0+uX/YiKvTTXbmDU6y1LUS79z2ygPL/ihRJFaXQRP2ab6Ccm5n0a
 wzv6Sg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0k9gb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 19:26:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-313d1015161so456829eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790709984; x=1791314784;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jcggai5cj02Q8AdG/I+0wRNZv2kOWaf+kgficKkoXVk=;
 b=O7DTy/f7Ye4b6DljsR5WuFimRAV0PZnovTvvMzRJdE5e/IFkKkoWcbJSO/YGBB0Eee
 X79kTexXBEdQ4EwXckQRfP/t68wHTuMhSvPDIryWfLmvpBk4OhdyDs2TiconeReDSnOm
 JE3qbMYByRxpASXuvLae0Tz3qOXCh7xedanQQg+6KHCIFKj7mRF6a1tFemsU2fqECRBQ
 4Oo5Pgtl8U/G+czOZisV1Je+IOzeZzBOrSZu2jO3eg3lpzvvdq5IeN0TrPSaVQt5DzRx
 WqQXZxc93F2scWN16VN5ij1533r4TneA6RkRyeMjrl1fEyGrDGwT0zcfgF01sIlNPrrv
 4Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790709984; x=1791314784;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jcggai5cj02Q8AdG/I+0wRNZv2kOWaf+kgficKkoXVk=;
 b=vk4D7Z9aMjZI1X/BeO1Ec+IfqrjOHy7xnGcmUEICbTdiyBUOLC90QUlMIhtuV+ZTgB
 TRPTZmBo5twVJmYZK1IvgpN69IYRLC3m7klAq5yLgsyHeia/EMpUqK3J2+vievKfIxE8
 4a9MlAfgY854INjo87JzSAOc37zU0f3kmdWw9F1kzXjiH/ukdiVxzOmHbwIs5daJVfuG
 cu9V/dXMK8ZKvHF/6Vj8jYa3VKJ5wXNSngVUfw57qh1fUfPFAbtf3kKzYI9z5rvwrQjv
 dWm7xq8o1AT5TEYD4syDqpAOCVLbXz1ogs/1Ba6oTbnEb7Gm+sldvpNzhaF2R2DNuZiR
 XxsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKUkwg+m07sLYYk78I+iq6T3Vq47s2tLCQtB3BpWFhD57vyTY9ZJHaLzQGYkYDbIPUfI4xWo53NYM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuI/VBIC4+sFQ01nRylR/pXTDRQVO/4qEp6rfrYxRcJXsYD+cy
 7y1DHO2JvKYsx4diia93oDLoCvosJPNU6nmurVMIKBXPQF2Upv36UVlV+M+Ly/Z/LVwAJrzmmvh
 IZVD15oxZAWZHa+nYP/buIUzBjdPw0ztKhcdxrsN5/7mIZbBo9Z3PRZEDIlVYSyDPhVKvcXI=
X-Gm-Gg: AYBFou1L+rBJXV1ukE0KhBsmWpwE7+NJR26f22XMO5EVNWxMeJ8wBQ3nClM69h1I8EC
 4n/3chgDMf7Ki/sq+tRlUrRz2F4BZQGsohvYi+8yGMTltThk3i30vJkdEZmj2GzoyGTFLpQpT0f
 0XlBUrbtrZvsLhum6o61jdWSbbtDmpaVg/wZ7iTcvQaMQmXuLronmpkN/0UheuNs7NbUp0dvBOl
 zl2ce/tguT9qnRgNJT0B+eYPadW/ca2R6VhKuku2Dapm4U+Su9Z79OGlT81iecrFp/0fCRsUzTa
 RIk5JMsLHzZrhfGv3n9kAItC/fUBTsohlyeD6OMx0NF1Xdeyb+7QwQg7FBoyd5hyWlsP9z6Ygme
 h+md5vW6yX5kq/r2ZQkZTwhU8gI45/kGjPwBwdAZthWQEXlZXevR/aA==
X-Received: by 2002:a05:7300:d203:b0:34a:fc46:35c3 with SMTP id
 5a478bee46e88-34c67ca5854mr293322eec.33.1790709983970; 
 Tue, 29 Sep 2026 12:26:23 -0700 (PDT)
X-Received: by 2002:a05:7300:d203:b0:34a:fc46:35c3 with SMTP id
 5a478bee46e88-34c67ca5854mr293278eec.33.1790709983268; 
 Tue, 29 Sep 2026 12:26:23 -0700 (PDT)
Received: from [10.226.49.37] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c38bf0948sm909179eec.25.2026.09.29.12.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 12:26:21 -0700 (PDT)
Message-ID: <d9bf5c75-91b4-4933-ac2a-33aace58cbbf@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 13:25:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeffrey Boody <jeffrey.boody@oss.qualcomm.com>
Subject: Re: [PATCH v2] dma-fence: deliver set_deadline callback even if fence
 is already signaled
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260922-dma-fence-set-deadline-v2-1-2338d6fac9aa@oss.qualcomm.com>
 <72e380d8-4b94-47d4-8721-a6f652dfd27b@amd.com>
Content-Language: en-US
In-Reply-To: <72e380d8-4b94-47d4-8721-a6f652dfd27b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3NyBTYWx0ZWRfX0ixCEZIEN1I3
 rnhIqpfKH33sJ8F7gm6ugXGR2k3bXm5OZmETc2HZq5d9jr2u2r+v7vK6dE4aDo83NUAkjzEHc6n
 DuwM4CZnUcL1ZAuixPy95G0ZVfbkWi0=
X-Proofpoint-ORIG-GUID: rYU-LDQbPJVSIsT7--TJ_EeUJZxnQbKi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3NyBTYWx0ZWRfX9Qu3LoSXHO+m
 lOS11M6qHE7KupSj/sDigfpdJHqiihTCk8aYq6CtebxEAxzLLebxKnC3ubNb8RUvnAUz4NF+GtN
 g/RXfxHy9f3IBQ+W+twpLAhieWsxq5LlJUDwjxQJ6638OkwxJFDaJpbzJY8yWPxqMfDINabat7Z
 jC5kYzsxaiGEblGuEpQK/rnY8C7LurCTaHsCZ6sQHLdEPGDtGQaU1RDsICe2anEuGz4JMvR5X+f
 5l93Eo2xUarOKg7Nj5QRaaPFT7txMOfT8HbYlSX5opKXb4IViHFQ//uHoaL6qTern7crYVmLWZC
 eUx0/gtybgRUs4uvnnW5lnoCbHR5v2Kq8dhvCfTHk68pOuBJzFtvdGcA8G4nCDpP4yGuHiAodeb
 465/FQpcqfQEvtsI2vBLsgdFx3reS1Lk6tyhv73V+H0fn5upS0A6Ebgc3Iz+9+O0a4ayqE5KMxm
 0hQb4bjt4rl5PulFlPw==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abc10e1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=a6woDCoF70UX9vXSefYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: rYU-LDQbPJVSIsT7--TJ_EeUJZxnQbKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290077
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

Hi Christian,

I apologize for missing this issue and will follow up if we can find 
another approach.

Thank you for reviewing the change,

Jeff

On 9/23/2026 1:35 AM, Christian König wrote:
> On 9/22/26 18:57, Jeffrey Boody wrote:
>> The set_deadline callback is currently skipped if the fence has already
>> been signaled. This prevents GPU drivers from performing power
>> management adjustments when the deadline hint arrives after fence
>> completion.
>>
>> In triple-buffered rendering, a staged frame may be completed well
>> ahead of the vblank deadline. When a display driver delivers the
>> deadline hint, the fence has already been signaled and the callback is
>> silently dropped. This leaves the GPU driver unable to evaluate the
>> headroom between the fence signal time and the vblank deadline, and
>> therefore unable to reduce GPU frequency when the target headroom is
>> exceeded.
>>
>> Remove the dma_fence_is_signaled() guard from dma_fence_set_deadline()
>> so that the callback is invoked unconditionally when ops->set_deadline
>> is present. Implementations of set_deadline must already tolerate
>> concurrent and repeated calls; handling a post-signal invocation
>> requires no additional locking. The fence signaler can compare the fence
>> signal time against the supplied deadline to determine whether frequency
>> scaling is warranted.
> Sorry but I have to clearly reject that patch.
>
> No callback whatsoever is allowed to be used after the fence has signaled or otherwise we break module unloading for the originator of the fence.
>
> So that approach you want to have here simply doesn't work at all.
>
> Regards,
> Christian.
>
>> Signed-off-by: Jeffrey Boody <jeffrey.boody@oss.qualcomm.com>
>> ---
>> Signed-off-by: Jeff Boody <jeffrey.boody@oss.qualcomm.com>
>> ---
>>   drivers/dma-buf/dma-fence.c     | 22 ++++++++++++++++++++--
>>   drivers/gpu/drm/msm/msm_fence.c |  3 +++
>>   include/linux/dma-fence.h       | 11 ++++++++++-
>>   3 files changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>> index bd58688b81a7..ebc7c5ca6f69 100644
>> --- a/drivers/dma-buf/dma-fence.c
>> +++ b/drivers/dma-buf/dma-fence.c
>> @@ -999,8 +999,19 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
>>    * Multiple deadlines may be set on a given fence, even in parallel.  See the
>>    * documentation for &dma_fence_ops.set_deadline.
>>    *
>> + * The deadline hint may also be delivered *after* the fence has already been
>> + * signaled.  This is intentional and supports the case where a fence signaler
>> + * aware of a periodic deadline (e.g. vblank) and the fence's signal time can
>> + * evaluate the headroom between the two.  In triple-buffered rendering, for
>> + * example, a staged frame that is completed well ahead of the vblank deadline
>> + * represents excess headroom; delivering the deadline hint post-signal allows
>> + * the fence signaler to consider reducing frequency for subsequent workloads,
>> + * rather than holding an unnecessarily high frequency.  Implementations
>> + * of &dma_fence_ops.set_deadline must therefore tolerate invocation on
>> + * already-signaled fences.
>> + *
>>    * The deadline hint is just that, a hint.  The driver that created the fence
>> - * may react by increasing frequency, making different scheduling choices, etc.
>> + * may react by changing frequency, making different scheduling choices, etc.
>>    * Or doing nothing at all.
>>    */
>>
>> @@ -1016,6 +1027,13 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
>>    * to aid in power management decisions, such as boosting GPU frequency
>>    * if a periodic vblank deadline is approaching but the fence is not
>>    * yet signaled..
>> + *
>> + * This function may also be called after the fence has already been
>> + * signaled.  In that case the fence signaler can compare the fence's signal
>> + * time against the deadline to determine the available headroom.  If the
>> + * fence was signaled significantly ahead of the deadline, the fence
>> + * signaler may choose to reduce frequency for subsequent workloads to
>> + * avoid unnecessarily high power consumption.
>>    */
>>   void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>>   {
>> @@ -1023,7 +1041,7 @@ void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>>
>>          rcu_read_lock();
>>          ops = rcu_dereference(fence->ops);
>> -       if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
>> +       if (ops && ops->set_deadline)
>>                  ops->set_deadline(fence, deadline);
>>          rcu_read_unlock();
>>   }
>> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
>> index 3dca8e09c192..3c5de96d4092 100644
>> --- a/drivers/gpu/drm/msm/msm_fence.c
>> +++ b/drivers/gpu/drm/msm/msm_fence.c
>> @@ -136,6 +136,9 @@ static void msm_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>>          unsigned long flags;
>>          ktime_t now;
>>
>> +       if (dma_fence_is_signaled(fence))
>> +               return;
>> +
>>          spin_lock_irqsave(&fctx->spinlock, flags);
>>          now = ktime_get();
>>
>> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
>> index ffa99b930843..839ef2e5dad9 100644
>> --- a/include/linux/dma-fence.h
>> +++ b/include/linux/dma-fence.h
>> @@ -264,7 +264,16 @@ struct dma_fence_ops {
>>           * an upcoming deadline, such as vblank, by which point the waiter
>>           * would prefer the fence to be signaled by.  This is intended to
>>           * give feedback to the fence signaler to aid in power management
>> -        * decisions, such as boosting GPU frequency.
>> +        * decisions, such as boosting GPU frequency if the deadline has
>> +        * not yet been met, or reducing GPU frequency if the fence was
>> +        * signaled significantly ahead of the deadline.
>> +        *
>> +        * This callback may be invoked even after the fence has been
>> +        * signaled.  In this case, the signaler may use the deadline and
>> +        * the fence's signal time to evaluate whether the GPU frequency
>> +        * should be adjusted for future workloads.  Implementations must
>> +        * therefore be prepared to handle calls on already-signaled fences
>> +        * without error.
>>           *
>>           * This is called without &dma_fence.lock held, it can be called
>>           * multiple times and from any context.  Locking is up to the callee
>>
>> ---
>> base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
>> change-id: 20260917-dma-fence-set-deadline-a778746e9abd
>>
>> Best regards,
>> --
>> Jeff Boody <jeffrey.boody@oss.qualcomm.com>
>>
