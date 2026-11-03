Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871F606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KQ2HdaFx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2626D10F6C4;
	Tue,  3 Nov 2026 16:02:22 +0000 (UTC)
Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A4410F6C4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:02:15 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=RNHlMa6RwOm9qVZaoJD2JFv05KQ6puOjifLF8tZtWyk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793721733; v=1; x=1794326533;
 b=KQ2HdaFx5molxhyTXGu3M4ewG2MnC4YPb2ViEfKzifJId+uWAv/qDjRJoeaP1srX7Q6XpUtp
 Oqz+0Tw3LSTKaiPzv/HrZmzR+b+SMrk5qcRYho3JDTZxaptaM6+zFzusvGAoCg8ZoAWyUoPQpM0
 X/uXPWvggQCtLO/dfEw01zcY=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 9fdc28ca13f7125a;
 Tue, 03 Nov 2026 16:01:11 +0000
X-Mizu-Trace-ID: 9fdc28ca13f7125a
X-Migadu-Flow: FLOW_OUT
Message-ID: <1a4eb0fb-adbe-4884-8f37-b5ffa6782b84@linux.dev>
Date: Tue, 3 Nov 2026 21:30:55 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
To: Alex Deucher <alexdeucher@gmail.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, dev@deq.rocks,
 dri-devel@lists.freedesktop.org, ed@aicharmers.com, kenneth.feng@amd.com,
 linux-kernel@vger.kernel.org, simona@ffwll.ch
References: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
 <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
 <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Alex
> On Tue, Nov 3, 2026 at 10:01 AM Atharva Tiwari
> <atharvatiwarilinuxdev@gmail.com> wrote:
>>
>>> It is the same issue.  I don't want two fixes for the same issue. I
>>> just sent an updated version of this patch expanded to cover more
>>> macs.
>>>
>>> Alex
>>
>> How is the problems same exactly?, Does initializing UCLK later change the
>> PPTable?, and as said this is not even a solution for iMacs, so why are we
>> still trying to upstream this?, and btw initializing UCLK later with 5K,
>> makes it not initialize at all, so the patch is just wrong.
> 
> I asked around internally with the windows team about this issue and
> was told macs needed to enable UCLK DPM later, but no one was aware of
> any uclk dpm patching.We have filed multiple bug reports regarding the 5K issue on iMacs but they have simply been tagged and left over for many years. Now suddenly one day a person without properly consulting the author sends a patch upstream, inspite of the author himself saying doesn't work.

I own a MacBookPro16,1 and the v5 send doesn't work at all to fix it for me.

Since Windows team is willing to help us please fix the 5K issue on iMacs as well. And the devs aim achieve hybrid graphics, which Windows does not support.

For my testing results, the patch in v5 (https://lore.kernel.org/all/20261103143014.522592-1-alexander.deucher@amd.com/T/#u) doesn't solve what is claims to. It might be possible its needed, but in that case even more workups and patches should also needed to get the GPUs running properly on Linux only.

I believe patches submitted by the author himself should be acknowledged. We already are victims of AI cannon, pls don't make things worse.

Nacked-by: Aditya Garg <aditya.garg@linux.dev>
