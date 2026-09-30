Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750B6CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C605810E98D;
	Wed, 30 Sep 2026 14:17:33 +0000 (UTC)
X-Greylist: delayed 5655 seconds by postgrey-1.36 at gabe;
 Wed, 30 Sep 2026 14:17:31 UTC
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B171510E300;
 Wed, 30 Sep 2026 14:17:30 +0000 (UTC)
X-QQ-mid: esmtpsz17t1790777801t7e15313e
X-QQ-Originating-IP: TTVepZbroz9T+Fe2nw0Bi2zy63iXi7HxHGfbTrCgrqE=
Received: from [127.0.0.1] ( [180.159.160.209])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 22:16:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11752197069327383604
Message-ID: <660A9181C8AC6F3C+a6eb53f2-fe2e-4bc8-8fd6-282a212cb670@radxa.com>
Date: Wed, 30 Sep 2026 22:16:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] drm/atomic: Handle max bpc properties before
 connector state allocation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-1-dbbf8b2b42bc@radxa.com>
 <quiwrspvimu5piokdswwqmaovv7arkr5swndnwjxhsgmipp6zc@itciwqnrilc4>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <quiwrspvimu5piokdswwqmaovv7arkr5swndnwjxhsgmipp6zc@itciwqnrilc4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N/Mt+zQrQboA54sMGaVeeGEtRo0V/8wr3u0DPjTjsz/5gxFvA7wfoXln
 KMgzK67XSad92vs1EW3Dw5FN8X9tLvrlIt+PmIbJp86bX5tG9Idzu8uvWnrQzmvwi4sgkmt
 hkV7KeGweoCvKpBqqPN8wdO0HEa9VVz9m9J+6tJdyAZIAnThkgRAF1y4Ecuk/0B+c4gEhzS
 6jY/3JCY0JfAjDQIMHxpPq5d8DfIVytrf0hJxx/hzZzn+DDJ7hz47ltdpUPGqHPlz+XaEKZ
 Uu6witX/pPPdlhf/h2sQPC0wcHA+Q+MsH8gHsY8pbKpQKjYA2ljoC7fux6Kqr0IkKD6litr
 O2BTJtv0Bl3mqQ3hj+zqwlVa2Fj5+r9YAbcCRWie02i6HJn7kDwH/+KgKNE0M+v0ivDcrs7
 +VB1Ah6btNW0W9nXshdylFfcugMPWvWHlJ1e23GkYrZ6myqUX2Xo2WMA+DUCGY+kPruw1gU
 3vzW04lAfnmEh5nGY0DUfc/zE3qSBsOv0KmwodBDd925Iig4kvz+QNlviaTy1u0Mu0jcrDn
 Z3/Kr8v4ghXHzhU01fBL05vOPLtW2kdhbUZ1aCp71l4DSZs1xP+bqKisOs8vPIf6uS3YBQl
 Pr3G/lRYKAZIZYKt9a3nuY0U78AA0Vw/Df/Z0cm0fs4GVlHD9rhmd41Rng0egZelXfiy1cf
 m4jKyN1eEGkEvs/4MMI4Mh3Y0cAHhzITj7Y3IY/1BNsAW8fFJGc5FVvwswSc20lsDS/CpsQ
 6i6raJchUrKshTnM2j47CnY5FxbyAoAj+XKk39muo1Z7EmiRPQZea961jj8oDKlDukFPJ0/
 9p0cM2AWVgrZjWJdqq1a+lB7nKa0M2mjhaJY7uBPPy84zNVbyd1LFl+7ZdKny+XC/2XplAB
 7byXyMQ5naOtl8PzJQzRtZqU+zZqNEzNOa2HhXSG8SAEzlx96wBllTxMMRy0RPLJ4uDjDa2
 Kzlb1lzzCKCX+GJzwDzcWWBB5zHXgq+3OzgDshDh7zlBD/5/ZimPYHeCDUOU2j/wghtwJn1
 vFJxsXLGds8wP4zi4gwSRRVbQ39wyML7GBpzz6rmxb6R/Vd8hHp0w+1GqLmiI=
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
Reply-To: sophon@radxa.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 9/30/2026 9:26 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 30, 2026 at 08:41:45PM +0800, Xilin Wu wrote:
>> Bridge connectors can attach the max bpc property before their atomic
>> state is allocated by drm_mode_config_reset(). Unconditionally updating
>> connector->state in drm_connector_attach_max_bpc_property() dereferences
>> a NULL pointer in this case. Adding max bpc support to MSM DP and eDP
>> exposes this during display initialization, before a framebuffer console
>> is available.
>>
>> Only update an existing state when attaching the property. Initialize
>> max_requested_bpc and max_bpc from the property range when creating a
>> connector state so that deferred allocation and subsequent resets both
>> restore the default. Avoid leaving the bit depth at zero after reset,
>> which would otherwise cause valid display configurations to be rejected.
>>
>> With MSM DP max bpc support applied, this also restores boot on the Lenovo
>> Yoga Slim 7x.
> 
> Hmm?

The boot failure occurred with the later max bpc patch in this series 
applied. I'll drop the "restores boot" sentence and describe this as 
preparatory support instead.

> 
>>
>> Assisted-by: LLM
>> Signed-off-by: Xilin Wu <sophon@radxa.com>
> 
> Can we rather update drm_bridge_connector_init() to register this
> property in non-HDMI cases if max_bpc is more than 8?
> 

Yes, that makes sense. I'll advertise the MSM DP/eDP capability through 
bridge->max_bpc and let drm_bridge_connector_init() attach the property 
for non-HDMI bridges with max_bpc > 8. I'll also handle state creation 
and bpc defaults there, following the HDMI path.

Thanks for the suggestion.


>> ---
>>   drivers/gpu/drm/drm_atomic_state_helper.c | 5 +++++
>>   drivers/gpu/drm/drm_connector.c           | 6 ++++--
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
> 


-- 
Best regards,
Xilin Wu <sophon@radxa.com>
