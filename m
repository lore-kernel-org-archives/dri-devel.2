Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EF81076370
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 05:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F26510E2F4;
	Wed,  1 Apr 2026 05:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="d3M2pXji";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9894910E2F4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 05:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775022492;
 bh=1zqNQlzQvZgzONTUlDEXkk0XrQwfQYtDkTgTaMTLRR4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d3M2pXjiJYXYd1/0Tec3q9sH/Agd8E4CE77T0c+ZHD1bEyHZ0GpDVB0yy/tLAVCzl
 IFX6hrj1O4JqTo3p/WCAj6JhJhpEb5kUpN6mfVeqfpzxelWZ2Lao1csZjus0Z1bakP
 CTWbhjkLGeTGmjqN2612QUsL8zaLJipy2xN7QN478ymIuktlfGfovBKx5ew0Cx+GX6
 OiHRy5LxnlMTZvfGFSmXh45GTHXD2Rlqtg4Y8m5WqkcZ5T/WlfVN1FtNTCnIFrVLPf
 aVnhxp6k8dkuCtCHJinAXO1QLa0BE6HSmsIPtCWRz2++cBHCifl+SqKBXOypyS0Wbh
 lBgsYgLVUJtQA==
Received: from [192.168.50.190] (unknown [171.76.80.25])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E327D17E72C1;
 Wed,  1 Apr 2026 07:48:09 +0200 (CEST)
Message-ID: <107b1aca-40be-4555-9541-e2a9d56f0b3f@collabora.com>
Date: Wed, 1 Apr 2026 11:18:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/ci: add sc7180-trogdor-wormdingler-rev1-boe
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260224081036.220820-1-vignesh.raman@collabora.com>
 <hnlupswfdkrzv45y6jl5x5u25zp2k642z6ordzthqbdw4azhxb@6gz5hx4dcujc>
 <fs6nbg44r2ralxrkuc7slciapnufyyw6derolzlwzt7hjxlx62@vftuo2vmfpom>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <fs6nbg44r2ralxrkuc7slciapnufyyw6derolzlwzt7hjxlx62@vftuo2vmfpom>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Dmitry,

On 24/03/26 00:56, Dmitry Baryshkov wrote:
> On Sun, Mar 01, 2026 at 02:23:40PM +0200, Dmitry Baryshkov wrote:
>> On Tue, Feb 24, 2026 at 01:40:34PM +0530, Vignesh Raman wrote:
>>> Add job that executes the IGT test suite for
>>> sc7180-trogdor-wormdingler-rev1-boe.
>>>
>>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>>> ---
>>>
>>> v1:
>>>    - https://gitlab.freedesktop.org/drm/msm/-/merge_requests/221
>>>    - Depends on https://lore.kernel.org/dri-devel/20260210071138.2256773-1-vignesh.raman@collabora.com/
>>>
>>> ---
>>>   drivers/gpu/drm/ci/arm64.config               |  4 +++
>>>   drivers/gpu/drm/ci/build.sh                   |  1 +
>>>   drivers/gpu/drm/ci/test.yml                   | 10 +++++++
>>>   ...180-trogdor-wormdingler-rev1-boe-fails.txt | 23 ++++++++++++++
>>>   ...180-trogdor-wormdingler-rev1-boe-skips.txt | 30 +++++++++++++++++++
>>>   5 files changed, 68 insertions(+)
>>>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
>>>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-skips.txt
>>>
>>> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
>>> new file mode 100644
>>> index 000000000000..4af93eeeaf99
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-wormdingler-rev1-boe-fails.txt
>>> @@ -0,0 +1,23 @@
>>> +core_setmaster@master-drop-set-user,Fail
>>> +kms_color@ctm-0-25,Fail
>>> +kms_color@ctm-0-50,Fail
>>> +kms_color@ctm-0-75,Fail
>>> +kms_color@ctm-blue-to-red,Fail
>>> +kms_color@ctm-green-to-red,Fail
>>> +kms_color@ctm-negative,Fail
>>> +kms_color@ctm-red-to-blue,Fail
>>> +kms_color@ctm-signed,Fail
>>> +kms_color@gamma,Fail
>>> +kms_color@legacy-gamma,Fail
>>> +kms_cursor_legacy@cursor-vs-flip-toggle,Fail
>>> +kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
>>> +kms_flip@flip-vs-modeset-vs-hang,Fail
>>> +kms_flip@flip-vs-panning-vs-hang,Fail
>>> +kms_invalid_mode@overflow-vrefresh,Fail
>>
>> I don't see this failure in the logs. If it is removed, then all three
>> failure lists (and all three skip lists) are the same.
> 
> Any updates?

I will review this again this week and update.

Regards,
Vignesh
