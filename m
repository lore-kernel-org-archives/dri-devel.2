Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82F606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gS6/WmEB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEF910E6D0;
	Thu, 12 Nov 2026 21:40:31 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B4C10E26F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 21:40:24 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a59ffacb51so407535e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794519623; x=1795124423; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r7tUMESnGuHT04Vkq8tfouLXmNvcHODCZ4NpjFvO4WY=;
 b=gS6/WmEBJLa+4fjNsEhKnlHKhgKZ3N6DabfpCPE1MvDbiamzBg1O9E3VBhUb2+7319
 aSkenE6vIIOo7KLXOYa7Cq0T7+9PbwNcndmCCziOSy1Nyda4Qa5/SGwoq8oa+ESStpvq
 tTRqN+jzmTD4mP2h9+gxtYSvWnu3kQz9Ssf879WXcseAfbHyoNUBDETi8lbBGY5e5JLp
 o5YqcdXWzhJz3f3OQcB6ZOH0BH88lfAMNvxzKpnAQYvWhuXBB1xVbIW6dtvdcbGWK48C
 yg7qkcywzNLbO9RQakp1JZh6/aXw+450gmpNCD0Op/K398ytz+NLrIjUkyBQEQpMyfJ+
 jIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794519623; x=1795124423;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r7tUMESnGuHT04Vkq8tfouLXmNvcHODCZ4NpjFvO4WY=;
 b=JLMDeQ+m9HZse9egnC6AEWddUtvi6BPmAW9Sg7/mcVgrUgzKNkEowhmDe7H9w+4ewo
 2JmdrAFzS1Ybl48Dks1OBU9Txb0KYdUEcDg9h/+j9fFCpvZYxmcZL1Y+0qXi+aSzpF07
 6m75oaaTt4KVAt+15+ZJb1IjvkV4gCiur7GFlU1Ztjq3BRJGikHY/AekBeDPK7KJYU+z
 UoEP2VGQftn0NLHm5rAQ5wGBOeW5pfl4d8W/WNN/CkBiLWwPqxnW+uh2T4RinVvZmpLe
 4a5C0qqHeoTtBJpSv5BmE0nONWV2HzTm2cE47LyxB2oJLHZ9isQrXaoTmFBf+Xdwcjjq
 P/vQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGicL49zcBle7pjhexBl8ltBkJA4Xw/iVT3YGXWd4Rgbern4ILiI8dBn87dnygMA+zc61y7UxTK4Z0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/S3x5tiO2z2Q8bnVDKxIIi91JFo4FLZ2fzUj77/RBv7bhkaSP0
 DDBgqd6tha6bDSvAjRoinA3Ljd7qy+HkZTveT/0H76RSw4dKCaDIJr+J
X-Gm-Gg: AYBFou3lSPq1Fx1ryKbuSRvxm7p7K3M0tqwwDWMJUzkBZt0L4E2uRWibfD8nfCPt+cJ
 kT8qST/3hRjuiIa4RlsBEOkO9U+uDsKezInyqIjmfRilY2LAqCP6GEEy2Wo4a1BWtfhY8zNimhL
 93Jk8im/PUaBJ846LVff+vVN8LY7q6Wf4Z6xmK/qkkd35sHCuEC9WwruSlwD+pHNf8c0XKWTR3Z
 /BYR69Gvzb7oiv2PdHoBV115uW0HpQF8y6cfeQbC1QdNm/6dNbB7dQsIpvTmAmDAcaLvueoPl8X
 UhU5DkkyDP1m7hcyzFyrO10MCWP/B8055v4gzNN/NUgd+9SO0R6Cn8pmvDoLlpp0ITYp+GoikrB
 AgGAOza0pZ9GIpfM6jsMvxpubTEzQYX0CWJNkd5mU7eXKu8RxRUH867ldePEyNGYtGLh4e464LO
 iinUhDzKT1hQfz6cAwq2jYSHcUGnOqpiwULea9DXfT3RnLkNs+Ycm5N7wbcI4rqdnNd5yg1GLPB
 Umhl919KkJLySXXAQ5Cee0FtkrW3kZp1/WpeWfZ6ECCy4W+jrGoy0mP7dNDGWhwH2quy2Km5bKm
 xxLZxVXe0F4BN71patwzKpDNevGG1axgUQarrfw4IbQwHrwlUHv1+7nu1wr2qjlmHCbaSDWYwyO
 lWKIUpIo=
X-Received: by 2002:a05:6000:40cd:b0:492:b1c5:6dc3 with SMTP id
 ffacd0b85a97d-49c723fc6f9mr1514901f8f.6.1794519623235; 
 Thu, 12 Nov 2026 13:40:23 -0800 (PST)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60021375sm1279890f8f.29.2026.11.12.13.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:40:22 -0800 (PST)
From: Marek Czernohous <mczernohous@gmail.com>
To: Beomseok Kim <dilddream31@gmail.com>
Cc: nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Fab Stz <fabstz-it@yahoo.fr>
Subject: Re: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
Date: Thu, 12 Nov 2026 22:40:21 +0100
Message-ID: <179451962164.1494544.10983579250194846394@gmail.com>
In-Reply-To: <20260928081450.19340-1-dilddream31@gmail.com>
References: <20260928081450.19340-1-dilddream31@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 28 Sep 2026 17:14:50 +0900, Beomseok Kim <dilddream31@gmail.com> wrote:
> nouveau_fence_signal() clears fence->channel before dropping its
> reference.  nouveau_fence_no_signaling(), however, removes an already
> signaled fence from fctx->pending without clearing the pointer.

[...]

> @@ -488,6 +488,7 @@ static bool nouveau_fence_no_signaling(struct dma_fence *f)
>  	 */
>  	if (nouveau_fence_is_signaled(f)) {
>  		list_del(&fence->head);
> +		rcu_assign_pointer(fence->channel, NULL);

I think this patch fixes drm/nouveau#443 [1]. The nouveau_fence_sync()
oopses there and in the reporter's thread [2] (MCP79, Debian 6.12.43,
6.12.90 and 7.0.10) all fault at CR2 0x40 on the prev->cli->drm load,
with prev taken from f->channel and prev->cli NULL. A channel's cli is
never cleared, so prev most likely points to a freed channel. That is
the stale pointer described above: the no-signaling path is the only
way off fctx->pending that leaves fence->channel set, and
nouveau_fence_context_kill() only walks fctx->pending.

The fix looks right to me. enable_signaling runs under the fence lock
(&fctx->lock) while the fence is still on fctx->pending, so the new
store happens before nouveau_fence_context_kill() takes that lock, and
thus before the synchronize_rcu() in nouveau_fence_context_del(). With
fence->channel NULL, nouveau_fence_sync() falls back to dma_fence_wait()
on an already signaled fence.

Emmanuel Fleury's prev->cli check for the same oops [3] only helps when
the freed memory reads back as zero, so I prefer this patch.

The patch applies to 6.12.y with an offset; compile-tested there with
W=1 only. I have asked the reporter (Cc'd) to test it.

I did this review with help from Claude (claude-opus-5-5).

Reviewed-by: Marek Czernohous <marek@czernohous.de>

[1] https://gitlab.freedesktop.org/drm/nouveau/-/issues/443
[2] https://lore.freedesktop.org/nouveau/b7f523dc-fe41-4514-a1a5-747005311cbe@yahoo.fr/
[3] https://lore.freedesktop.org/nouveau/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.fr/
