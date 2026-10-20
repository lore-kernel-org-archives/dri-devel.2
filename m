Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B348606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KS3COTqU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2A410EBA1;
	Tue, 20 Oct 2026 09:46:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E78910EB83
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 09:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792489596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rg/n5h2LZhb8d64uxndMAHWeaRWn+OTmWTZK6zmxraM=;
 b=KS3COTqUWQ3pRdxJr7H5QDCynu0AnWRjjOJ75l73FvBQTtLDUaNaLf8dvGajsV4mf06Cj/
 pgB9ko/FYIVWw8EcNPs1wFuuiv0pzP+ceoDKoLhP309EdSslLIVuKwARvnGOMR3KareSJe
 8OR6B/WmAh4KXIG5BSc/c24rvzToc2g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-_bQo6nGxNmiFYCrZatSQ6w-1; Tue, 20 Oct 2026 09:46:35 +0000
X-MC-Unique: _bQo6nGxNmiFYCrZatSQ6w-1
X-Mimecast-MFC-AGG-ID: _bQo6nGxNmiFYCrZatSQ6w_1792489594
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1e295b702so23153175e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 02:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792489594; x=1793094394;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rg/n5h2LZhb8d64uxndMAHWeaRWn+OTmWTZK6zmxraM=;
 b=g9AxodWacuEaNlE0fciOu1WxTKoidkPc28GKBMxRkyQCxfjzaz6T73pX/rVPmtBg3B
 Rl6LipawpQZS53A/xWAqoiiCnNfbGIWnRBWqZBC0n8H6nQ+Z73o1f1lMdaW5P2GB9EZ9
 hXG/wba8Q2LA1dVkn3462SSclyuTuibucxuErtmWYsoccOLzqMCqG7MLid2wxnE1jaXm
 NmFYgeEeo0jZCrbhwc2ffRYVDR5l/neSE45TR7NINQkFK3nPxx3V1YtsWBcYXUu6of7w
 GXCS43NFsatzGe1Ld7LbANkEnJJIqwBFGDmvCOPeaRR2H7VSSZZeUV6axKG9AvRCc7Ks
 xsGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBws9DazCtv46IMK47BOiG4Ih8MI3ud67OEHA2rHk/qeebSCoAlyfXtczLfXZlfEmZw7vE9hI/nyZiU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIHMdIYQ8ao/Om1ATtUhA29ZuBpam8WIrLQZ9tLOE4ltaKGx3J8
 Cs1cpqCFJ3PhKvzPhb6qgM2XXor8RPzu4EHD0omYY7jiq4bRdNNrdDJHet78AYAtiyaN5j/kUdn
 W6oWCnUK5DwyoF6SPYDo5aTJCz9LxxlmlRXsVG9EwRO3dDIDRpvvWIln7YsMjmhQ21TCFPQ==
X-Gm-Gg: AYBFou2P2LkSHHh5LOFvq9uNnieLTfn4CPvV52h2DoneP4n8e1mQixDhhEqlw77akdR
 xxla7Ma+1sc6HS0LloLDFlsNudlufXdXpIGWHntNHXN7GWlTF7dDCBel3YivWANki7FhoRQNC6Y
 eN2Q6PLM/C7KSATihiTc4yR9fbfRQexvoR2yM6ADzwDJlY5N9PMK1MWb+Rf342L/cceYW95h9br
 +RT9M0+DMQVIGY1nh3ZmkF/+DPe5kvoMK1OGjQuQOqTAsEcEX2zwDeJYPPoWFuDIwKEg4YKEh8+
 6IuqSMqrVOf9vniGZphUHjHs80v+Po2nv0ID3bEwo0ApqHoWnDmYGaUpObdM9IFswKcL0w==
X-Received: by 2002:a05:600c:1d05:b0:4a1:bd69:526f with SMTP id
 5b1f17b1804b1-4a1d75ab235mr205130885e9.4.1792489593858; 
 Tue, 20 Oct 2026 02:46:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1d05:b0:4a1:bd69:526f with SMTP id
 5b1f17b1804b1-4a1d75ab235mr205130435e9.4.1792489593344; 
 Tue, 20 Oct 2026 02:46:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c9f301sm52047555e9.2.2026.10.20.02.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 02:46:32 -0700 (PDT)
Date: Tue, 20 Oct 2026 05:46:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <joerg.roedel@amd.com>, "Nikunj A. Dadhania" <nikunj@amd.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Removing __get_user / __put_user for good
Message-ID: <20261020054227-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q1ls0qUf28uRdzk6DqfbaPqrRpvDsWg6Wptq-Y8UZKg_1792489594
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 09:25:02PM -1000, Linus Torvalds wrote:
> Bah. I made this branch of mine public because I wanted Michael
> Tsirkin to check the vhost part.
> 
> But honestly, the i915 side and the coco/SEV patches are the much more
> interesting ones.
> 
> So this brings in some new victims^Hpeople for that git branch to comment on.
> 
> It's all in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> uaccess-cleanup
> 
> I haven't dared actually boot it yet.
> 
>                     Linus

vpda seems to survive light testing in a VM for me.

Tested-by: Michael S. Tsirkin <mst@redhat.com>


It's still buggy if there is a swapout right before
the access, just like it was previously, but hey.
One splat less. An improvement.

You might want:

Fixes: 42823a871fd4 ("vringh: support VA with iotlb")

with that, vdpa/vhost bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> On Mon, 19 Oct 2026 at 20:51, Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> >
> > I have a whole branch that removes __get_user() and __put_user() entirely.
> >
> > Somebody should check that I did it right. But I didn't want to do the
> > pagefault_disable() around the vringh_notify() part, so it's not quite
> > the same as yours.
> >
> > Let me just push it out. I was going to let it simmer, but your email
> > made me go "I should just let more people look at it".
> >
> > Mind taking a look at the 'uaccess-cleanups' branch?
> >
> > It builds for me. That's all the testing it has gotten so far. Blush.
> >
> >                    Linus

