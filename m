Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18B6CD5BD0
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 01:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FCA10EB4A;
	Thu, 28 May 2026 01:57:39 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B0F10EB4A
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 01:57:36 +0000 (UTC)
X-QQ-mid: zesmtpsz3t1779933411t051b27aa
X-QQ-Originating-IP: Xo+WVLqeetR6zv4ASWWCm/TADq7Vz3fao/NqAUF+c7w=
Received: from [127.0.0.1] ( [116.234.26.110]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 28 May 2026 09:56:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3255798331960100904
Message-ID: <755BEADC478F92B8+16dd5a2a-9a6f-44c2-a84a-af36675a3346@radxa.com>
Date: Thu, 28 May 2026 09:56:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] arm64: qcom: Enable additional hardware on Radxa
 Dragon Q6A
To: Gekko <graham.oconnor@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, neil.armstrong@linaro.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522101323.31911-1-graham.oconnor@gmail.com>
 <15015D7EB84640D6+cc21a9f7-ae1b-4a22-bb38-34d6fafe1bcb@radxa.com>
 <30edf212-f656-4c09-a066-d765debf3fcb@gmail.com>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <30edf212-f656-4c09-a066-d765debf3fcb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NRKJMD5h+iEjzJzDoUhUVCMxOonf5Rfv1htmL/YEXz2YFNh+Fr9tMdKt
 0aLxoDSd5nDGm1Tp79qNInPrXH7ks9vd6r4OXJgp6ttH7NXMI78Kp0d8I47yR4bdSEp5KZz
 c+A9Y4ZO09eHZ0HOQ0b8t0l3KoXfhlJbdfkVUbpPMnRM8qPGfjjx3NYDpY1au73sr2H7O0/
 K+mwGBrxNOYl0cq7AgRpq4lR+p/ojsa8xHS1fVVtG8uH8vEy1Ddd4f3KML6HTnplO5V/BpJ
 WPPqUKs2bYpj2+Xkno10gZcoKDs4mozh58yPVPGAnFGZEXiaQ2zqFIWc3fXGdUG+bUryDME
 SsG6/GEYaPz1lIX7NusGW/zsb5a66nnjC+C+HSDC/wBrFkwHIltvCPb89COO+YN1LYb+CXb
 0OPiofi/d7lDtt9kc5QIKoNXpp0Tm8ugyy+uGcjBLNYuYdQgw8vizdDPnDqQCafIUBUbavv
 oInKbT7RH34gKxEBuyvSvCdWLxCGAentkovr7naT4ZAK7vp5STne7HDWSvMY0H9H08wK+iW
 D8MFCN8L243NbRAKNk4uuG+XTBjZ57Aj9fz9/d0iHeVfHAwqUeqThIx51HluwFMrlIRkbQv
 0rVa/cVCb2eq/071P6us8HuIzhrmaLw0p2sjyLVgJZ3Hxr1NG1iMXiEO3uJn/VksGg33NO2
 b0uMdHEAjGA7/tZiJMIEH/Dv66gxe1SPF85tQiV5LZvfm0Ur4rk2m+QdkrSaHTmLdX0FPJl
 BMX8hE8fHv1EpLsyAxThdAS1FLxywzgIgo/IroEFAAvgsWE31n+uTP0iy1/x9XKo+rJKlDC
 Wt6pLkvpBfyX8Nep+wmGlMyIC3680HbBuCkGbtnXan+UB/aS9qRK4iyKTKYz/+sDCmqmaPY
 Ql/ieWDAIv/DDxAlDnK3f7oXmlWE1U1cYp3yQ9oIWSJVachQtELaHhpAz3/twaKtDcxIzPs
 q2p3V8tyjo4SjzQngPFTOCyKDSAv19LS749lQ2Swche/jBf8kZKlK16XvmJuxrhk8q/oput
 OEEV91POCpY73b9Mv9aw56wnAaoWl/WBVLxBS/VAJ2HBfcxrS/G1hpLujE1KMdZWIq7rygb
 uRICJR5oAyQ
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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

On 5/28/2026 4:43 AM, Gekko wrote:
> Hi Xilin,
> 
> Thank you for the response.
> 
> I appreciate the offer to take over your patch set to move things 
> forward. However, I feel I must respectfully decline. This is mainly due 
> to my lack of experience with both upstream kernel development on this 
> hardware and the patch management process itself. It would be 
> irresponsible of me to take on something that I'm not knowledgeable 
> enough to ensure successful completion.
> 
> I'm happy to work with you to help in any other way that I can such as 
> testing patches, but I think you should maintain ownership of the patch- 
> set and submission process, at least for now.
> 
> One of the reasons I withdrew my own patch-set is that from what I can 
> see your series covers everything I was trying to achieve, and does it 
> correctly :-)
> 
> The only one that isn't covered is the patch for early TCS 
> initialisation that I'm discussing with Konrad which may be unnecessary 
> anyway.
> 
> Graham
> 

Hi Graham,

Thanks, I understand your point.

I appreciate your offer to help with testing. I will do my best to move 
this series forward once I get the current work off my plate.

Thanks again for your help.

> On 24/05/2026 13:58, Xilin Wu wrote:
>> On 5/22/2026 6:13 PM, Graham O'Connor wrote:
>>> Thank you to Konrad, Neil, and others for the very prompt and helpful 
>>> reviews.
>>>
>>> Based on the feedback received, I think it best to withdraw this 
>>> series to
>>> address the issues raised, most notobly:
>>>
>>> 1. The DP_TRAIN_LEVEL_MAX change (patch 3) is too broad - it affects all
>>>     devices using the Qualcomm MSM DP driver rather than being 
>>> specific to
>>>     the RA620 bridge. A proper fix should be implemented at the bridge
>>>     level. This is going to take more investigation.
>>>
>>> 2. The display DT nodes (patch 5) should use the radxa,ra620 compatible
>>>     string per the existing Radxa upstream series from Xilin Wu, and the
>>>     lane ordering needs correcting.
>>>
>>> 3. The rpmh-rsc early return (patch 1) needs further review regarding
>>>     the implications of returning before full driver initialization.
>>>
>>> 4. DTS patch label dependency issue (sorry)
>>>
>>> I'll integrate with the Radxa upstream effort, re-evaluate the other 
>>> areas
>>> and resubmit corrected patches addressing these concerns at a later 
>>> date.
>>>
>>> Thanks for the feedback.
>>>
>>> Cheers
>>>
>>> Graham
>>
>> Hi Graham,
>>
>> Thanks for working on the additional hardware bring-up for Q6A 
>> upstream support. I'm really glad to see someone pushing this forward.
>>
>> I actually posted a patch series [1] last month, and it is generally 
>> in good shape. Unfortunately, I got busy with other work and haven't 
>> had a chance to send v2 yet.
>>
>> If it helps, please feel free to take over that series and fold your 
>> additional patches into it. I think that would be a good way to move 
>> things forward.
>>
>> Also, I believe patches 10-12 in my series are no longer needed and 
>> can be dropped.
>>
>> Thank you again for the work you have done.
>>
>> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/? 
>> series=1078242&state=%2A&archive=both
>>
> 
> 


-- 
Best regards,
Xilin Wu <sophon@radxa.com>

