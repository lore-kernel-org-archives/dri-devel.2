Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B21D3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C51410E098;
	Wed,  1 Apr 2026 07:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EIwv3Mfh";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E4C10EC3B;
 Wed,  1 Apr 2026 07:46:20 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4flxr86687z9tjF;
 Wed,  1 Apr 2026 09:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775029576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/lKwjgSR9B7dpqAx3+zN6wocdRLjAthcFiDFA3urfI=;
 b=EIwv3MfhmcHe7xoCqFeKAzhpbqzv9Au9KKVBYV0H/shF8oR03CWEkv3/x7ApqnmFO59ce0
 2t4Mvsv3ZoDZ8V5mLDFbvtKWAXoUTa/kM63gcT9tsPElAFRGR6o63WxcxZBDHMOOTuS8ar
 thvvU0091gP8H2cb+kQAZBtV1hjQHlmZg5FeFFJ44eJeX6zOfIjKyweC4QlzCJfW3Uv4eT
 jQ/dhVBo9mB+EIfm1ayFWAGsEZ8X1sFDTFXpXSKl9raJaau7B/ivK73bP8oaUmWPPGfKuD
 dlstygGbIg8U3KJCpnkWEP0WiwJH3OgupdBhBpZdQYZqhw+NEHgZPoqRxxQqkw==
Message-ID: <7ad74724-9233-44ed-9b54-4c88a6a4f255@mailbox.org>
Date: Wed, 1 Apr 2026 09:46:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8676926.T7Z3S40VBb@workhorse>
 <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <20260326155305.736b4e64@fluorite>
 <47325395-3790-4cb4-8efd-84a3d8ddb80c@mailbox.org>
 <20260331153805.376486e2@fluorite>
 <d9abba15-382d-4bc1-a58a-71bb8413eeac@mailbox.org>
 <20260331172105.271c677c@fluorite>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260331172105.271c677c@fluorite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e7243fd9641255444cd
X-MBO-RS-META: d8jt3igqahjq1xf3shwfnyhz7qfjhouj
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

On 3/31/26 16:21, Pekka Paalanen wrote:
> On Tue, 31 Mar 2026 14:56:22 +0200
> Michel Dänzer <michel.daenzer@mailbox.org> wrote:
>> On 3/31/26 14:38, Pekka Paalanen wrote:
>>> On Tue, 31 Mar 2026 10:01:59 +0200
>>> Michel Dänzer <michel.daenzer@mailbox.org> wrote:  
>>>> On 3/26/26 14:53, Pekka Paalanen wrote:  
>>>>> On Tue, 24 Mar 2026 17:44:21 +0100
>>>>> Michel Dänzer <michel.daenzer@mailbox.org> wrote:
>>>>>     
>>>>>> * There's no clear use case.
>>>>>>
>>>>>> This is generally a requirement for new KMS UAPI.
>>>>>>
>>>>>> The practical usefulness of the corresponding weston MR is dubious
>>>>>> per the concern above.    
>>>>>
>>>>> I think the example of RGB 10 bpc to be degraded to YCbCr 10 bpc
>>>>> rather than RGB 8 bpc is an excellent use case.    
>>>>
>>>> This series and the corresponding Weston MR aren't enough to address
>>>> that use case though, are they? All they achieve is logging a
>>>> potentially misleading warning.
>>>>
>>>> It might make sense to combine this series and the Weston MR with
>>>> whatever else is needed for that use case.  
>>>
>>> What do you believe is missing?  
>>
>> For the stated use case, e.g. a mechanism to control RGB vs YCbCr?
> 
> There is no need for that. Currently the driver chooses the color model
> and depth on its own. We just want to make sure it's not too low.

What can be done when it's too low though? The only thing I can see is setting a higher "max bpc" value. If that's acceptable and helps though, why was the lower value set in the first place? (Otherwise the weston MR doesn't log the warning)


I feel like I'm still missing a piece of the picture for the practical use.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
