Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00E606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6Uk9LyW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC3410FCE8;
	Thu, 19 Nov 2026 07:48:55 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0989B10E7A6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:29:24 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so12812175e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795019362; x=1795624162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZSRZH5msDFAjfgDBh3dfHKyV/WnjnWDr4CZ2aEbCI0s=;
 b=L6Uk9LyW3FADciLEjrhj85uQH9P1yYMHMKo0v1a4F744e19/T5dvRx6ZBNbz/7OL4m
 DXv4219qJ4pIhGmz16zk1fH7A62PmCs93ti9O48bq4hl8o+KzEWBGOj/blyJZKOT7Uog
 IiML8Hbob1T3HKaFnPQ0h9l+zM/Pb62jqKoHV2UHs/hl0PMDpZqIYS47rmVMETKzmwKD
 ypmIC6FWG3P4NVKW4u2TP3j1M8PeXzeuVyR90Lrl8GV/uLI+6owXvA0biYiuVePbYGZk
 DRP7AkSEiwIAtlvLfC/I5OrTkvASdBcFiohOfqgw7cqipjxSbM0+TaDNDkyX/bWTVV7w
 sycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795019362; x=1795624162;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZSRZH5msDFAjfgDBh3dfHKyV/WnjnWDr4CZ2aEbCI0s=;
 b=noT4VBZerfvR1o3/PKOp4x2/WKCm4nMcPMnDZ8IS/3RWf8Qx3NzwR5YOZ9BeEIHeql
 Uz8FdYFH3w9M+qHgM9wuSQ1oc/DNDDedh6dbBFJVSEejrt9xCxcJ4UrHGzLp/m/f3y7B
 rK4tAIWOiGRjgFANVSOQ+CHQa9ZOsSpuI1mfUKj7pCIm5o94qWW2kytFZ42MTiwQZNa4
 C2hrbPFqwHuzUUpcC/8XELDH68iQAgaUHFKiCR/cWyPRiM+XLz4V3IsgvhXe0NMBsKLf
 D1wM2gKaTYj5OEpu8qW5oLAuvHWeO9mNrhSR0ITfiEcmbi6lpVqT4cAGjf7mUkkYbujd
 EnKw==
X-Forwarded-Encrypted: i=1;
 AL+hErEmCTfVwAnQZMySTyACFX37zUyTaU4up3YKMaWkOSoEPT4yLvmydhn+BcV0gBZJbkHLyP9vV7GSnRs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9BChJrvzqm14Kp/I8aK+pwwXqRCqfJILIG+8d46jnCP1NOQr0Q
 id79O9jFXqcb0PUc+g2KrDxc3JGJJPpq8/zoIE/m0ng2K3WJFx93EIQs
X-Gm-Gg: AYBFou2m86JCvrBd48UushIvfK410dPptuGmap+IJ6i39GpMHDqQiZPLtJMcQwJWts6
 rp5/61Lkb8xD3xaxU6eNJJpGofqroMPQWe8GR9KnUEwT/LY6wWcCei+ovFvhk14SVtMk5YgtQ6y
 zKkOZPwa56qPW05u1ASPjc9kiQN7gpOogcpge7QGt7+42lmpRIeXFsH0DaRNzxPL4DuDSAvPTPd
 yLe5jikkIYsBSjghYZCW+ZyF6TMF7uAxkC1Ms9v3lLinCZ+y5axSiVoKi589e+yN5sFBxxKyCRl
 1K8HlvB3tBL/aKCnato7YzOJlHFB9orYgqS5Yp+uMoP9MHB3Km9Sp2nFOKRbjM1ihKx59pMnS+5
 1C46IE2iCd7/CtksOo+09WS27YDUSSEBiTkbdrA+lo5aD7OSVRLssMAZlOrtYR0DFNqvnTmVWXl
 OEZJZdF3YZTryPcLCpgqWKxHZ9H4kab6ONi2Qw1wwAi4QFYBA0JVYJV6rSijnepA0eEhp5VrJH2
 XHK1PAiraBGdpvWdF4fps+HKQJdMrwjszd75IKoSSbx1RVlf69WpQx+DDdG9Ot5zwLUa5nh1eWB
 lmU545AFsNL7Uye6zeno5VFslOH9g5drKMcmwc+KWGPgRURxMnJiGsFwY0swO3KA76bP3JRlOqJ
 LlCIwFXDU41zgdc2E5NyoQKZHfF4SlSDBj9XsmiqU3KzPR0PUG0HbpFEt9tO+zNg+
X-Received: by 2002:a05:600c:1c0e:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4bb7da1c563mr79105745e9.15.1795019362133; 
 Wed, 18 Nov 2026 08:29:22 -0800 (PST)
Received: from ?IPV6:2003:d0:1f01:4100:1c6d:53c3:6172:7e45?
 (p200300d01f0141001c6d53c361727e45.dip0.t-ipconnect.de.
 [2003:d0:1f01:4100:1c6d:53c3:6172:7e45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2b8032sm77228715e9.10.2026.11.18.08.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:29:21 -0800 (PST)
Message-ID: <3458ff8e-a82a-42ac-9d1a-59a6a27e32d0@gmail.com>
Date: Wed, 18 Nov 2026 17:29:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
To: =?UTF-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Richard Hughes <richard@hughsie.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
 <20261115082042.1902826-1-Wayne.Lin@amd.com>
 <c6d79680-1fd2-4e71-9d00-616010b7727c@kernel.org>
 <QU464501lRPW3X8es-jXBFOvvwqS3eKR3HRS33U6x6o5eYC6h5AKV7f3ZXRCaU7-sEcupJMHereqyDUsUSG_fsOMNwvGO_CcZRKsz1AgObk=@protonmail.com>
 <5386db0f-e9b3-4c62-bb2b-392cca4d761a@kernel.org>
 <0TqebV7r6TwuSRlaon2zTcY7N7UqY3fhGl1WDQ7U9iw4c_dTzijuuXkEWxUWSCqk2U-Rx7j_vjaXfaKNu0ohsM7esirKVbIOeLrsiuYMsOc=@protonmail.com>
Content-Language: en-US
From: SimonIT <simonit.orig@gmail.com>
Autocrypt: addr=simonit.orig@gmail.com; keydata=
 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
In-Reply-To: <0TqebV7r6TwuSRlaon2zTcY7N7UqY3fhGl1WDQ7U9iw4c_dTzijuuXkEWxUWSCqk2U-Rx7j_vjaXfaKNu0ohsM7esirKVbIOeLrsiuYMsOc=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey guys,

Thanks guys for working on the fix!

How do I test the fix easily? I've never compiled or installed a kernel 
manually. Can you give me some hints? I don't want to corrupt my 
installation

Greetings
Simon

Am 18.11.26 um 17:07 schrieb Eren Özen:
> Hi Mario,
>
> Thanks,  the patch is below.
>
> With v3's ddc_service->link check the test passes even without this
> change, so in v4 it only makes the test set up the adapter the way the
> driver does. I tested it on amd-staging-drm-next 8dd68a79583a, which has
> v2: the three i2c_xfer tests pass and the suite runs to the end again.
> The one remaining failure, dm_test_fs_caps_dp_vsdb_version, is the
> dropped FreeSync hunk I reported on Cooper's thread.
>
> One thing for v4: if it keeps routing on link->aux_mode, the DP++ case
> from my last mail still applies. Simon's testing probably won't hit it
> unless he swaps a native DP monitor for a passive DP++ HDMI adapter on
> the same port.
>
> Thanks,
> Eren
>
> -- >8 --
> Subject: drm/amd/display: Give the no-DDC-pin i2c_xfer test a dc_link
>
> Since commit 48b8c06b05ad ("drm/amd/display: Route connector DDC over
> AUX for native DP sinks"), amdgpu_dm_i2c_xfer() reads
> ddc_service->link for every non-OEM adapter before it checks for a DDC
> pin. dm_test_i2c_xfer_no_ddc_pin() builds a ddc_service without a link,
> so the test now dereferences a NULL pointer and panics the UML kernel.
> Only 670 of the 1931 amdgpu_dm tests run.
>
> The driver itself never creates a non-OEM adapter without a link:
> amdgpu_dm_create_i2c() already dereferences it. So fix the test rather
> than the driver and give the ddc_service a zeroed dc_link.
>
> With this change the three i2c_xfer tests pass again and the suite runs
> to the end.
>
> Fixes: 48b8c06b05ad ("drm/amd/display: Route connector DDC over AUX for native DP sinks")
> Link: https://lore.kernel.org/all/sashiko-outbox-195461@kernel.org/
> Link: https://lore.kernel.org/all/5386db0f-e9b3-4c62-bb2b-392cca4d761a@kernel.org/
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Eren Özen <erenozen@protonmail.com>
> ---
>   .../amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c  | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> index 33082a674d9e..87dc722715dc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> @@ -6455,7 +6455,9 @@ static void dm_test_i2c_func_returns_flags(struct kunit *test)
>    * @test: The KUnit test context
>    *
>    * When the backing ddc_service has no ddc_pin the transfer bails out early
> - * with -EIO before touching the message buffers or the dc handle.
> + * with -EIO before touching the message buffers or the dc handle. Non-OEM
> + * adapters always have a link, so the test gives the ddc_service a zeroed
> + * one.
>    */
>   static void dm_test_i2c_xfer_no_ddc_pin(struct kunit *test)
>   {
> @@ -6466,6 +6468,8 @@ static void dm_test_i2c_xfer_no_ddc_pin(struct kunit *test)
>   	KUNIT_ASSERT_NOT_NULL(test, i2c);
>   	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, ddc);
> +	ddc->link = kunit_kzalloc(test, sizeof(*ddc->link), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ddc->link);
>   
>   	i2c->ddc_service = ddc;
>   	i2c_set_adapdata(&i2c->base, i2c);
