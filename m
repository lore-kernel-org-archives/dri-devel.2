Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F8606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qf/RRXJJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E4110E0F1;
	Mon, 23 Nov 2026 21:11:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DCD10E7F4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795468301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9pevu1TMmDcshsy2csnNqdpdxJkEoVnA4XxB7oiN7w=;
 b=Qf/RRXJJ+xiJdWH5jZ+FsA+TP5tr13wrBonP6ZtVdUAivNqLsh2O4yCnueHKVx4nfVb6ov
 SjpYmWfxt3KURj/+IPvawZ2iHF+sWH793IUC1T+bG+v9wZNx4Q9IbzhVsebEm2Af79Ao4Z
 qP0M381oKc2YeSXnE6oNWx1+ht2mHUY=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-ut29YmtHM46Rpdi1hCOGMw-1; Mon, 23 Nov 2026 21:11:38 +0000
X-MC-Unique: ut29YmtHM46Rpdi1hCOGMw-1
X-Mimecast-MFC-AGG-ID: ut29YmtHM46Rpdi1hCOGMw_1795468298
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-382af5cfc58so1834061eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795468297; x=1796073097;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n9pevu1TMmDcshsy2csnNqdpdxJkEoVnA4XxB7oiN7w=;
 b=QU2zhOunMCjqZh+TQd68FfFxlqOpUB7wagz00O3zGt/7Y+q+fl2L1MVK0wszh+wUOU
 0WTyWGDdfZ+XtG5tS+hvFdMnDDdTwi4Vj6pvyBlFgeFvSrvBMZn3Y7tsra3OtOgqCxQ/
 X1I+vsp23tKoN8XdyTy30n4KHH7ctC0Sp6V5Wia4rTSGjll2jocD3VGEq7lqjHsQsKwF
 GeC71n+FgCGrLNdivrWStJ8kb5wFB99tK8ya/diQaYr6/IWUYQze7Cs7VFy0AMMe9Zx6
 7agfgwZieBvbcc+cVV34JlDB83NkJi26CXQrd7kpqFBIL48/CQkrNqcKMfGnhOh3m3KE
 mA2A==
X-Forwarded-Encrypted: i=1;
 AL+hErGG9V7fs8+oB5xyQIInPQ2I3qnRwn57YBlMKi+i49sxyf0B1TqLNIR5Cgf5uNztraQCwSh8KzYNVP0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+d0QTE6N+1wI4ffc62oDB4yOtWenjzzzTEiUgtGBtqRXQd2tsn
 ktofkyrJ94t+2VucykRPbyMMAUVzbRDncz+eJ+B77i9PnoSCsPWVaG/7PFfOSCHhSCLpTAR/IxJ
 Zrwn3H08eCkIDKh/LHonQOghjqjTMjgStUIhYMvyRaj+/2tfzAf4ddNYTQq7jqRtR0M3de5JzHU
 XV3WNidASGXdse0YAdf9sF2ZJHUh1sQzZxueCDpJRxHMwS
X-Gm-Gg: AZFdTZeVjO5NHLBacP0oyNE8QVPJCuzvJmO4gk3BlVissaVGVvVXEFRyExJoc6iyokv
 syg0x4SNaeuLP2aPYedxjjwjYlKWfsR240GTkR7LygIkHfkX/uNj+ShYbEi7G2tK4W+deI9ZXjh
 KbovCayZ0B/Sm+f6SXUpGQkT4JgE2K8k+Rybvo1ZioA3JnyI6ceSu9SP5lNkPXcnaIfDjxsgCdi
 z5omFatV0xv0MPq
X-Received: by 2002:a05:701b:4558:10b0:1b3:b4cf:8f18 with SMTP id
 a92af1059eb24-1b556926cfbmr13460411c88.41.1795468297315; 
 Mon, 23 Nov 2026 13:11:37 -0800 (PST)
X-Received: by 2002:a05:701b:4558:10b0:1b3:b4cf:8f18 with SMTP id
 a92af1059eb24-1b556926cfbmr13460369c88.41.1795468296661; Mon, 23 Nov 2026
 13:11:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-2-5e8c27aa8555@redhat.com>
 <617a6fcc6a541f27351fb7f5abe21fb89553438a.camel@nvidia.com>
In-Reply-To: <617a6fcc6a541f27351fb7f5abe21fb89553438a.camel@nvidia.com>
From: David Airlie <airlied@redhat.com>
Date: Tue, 24 Nov 2026 07:11:23 +1000
X-Gm-Features: Aa3M54p6fvlOZnXQWzVJ7rxsais-R4gxmnSrBvqgceCPwlHjYyde1II3OXoWZMs
Message-ID: <CAMwc25rDmsXw++KeE4OhTCGCq0PRUZJJQaEMXY2dbvdwWzyL7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/nouveau: add option to leave GSP-capable GPUs
 to other drivers
To: Timur Tabi <ttabi@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 "lyude@redhat.com" <lyude@redhat.com>, 
 "dakr@kernel.org" <dakr@kernel.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, 
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PLxU2Z4iiKLhXlyr7oW4lDyXMLYqBwi0FuaXEl8CC6s_1795468298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 3:34=E2=80=AFAM Timur Tabi <ttabi@nvidia.com> wrote=
:
>
> On Mon, 2026-11-23 at 12:50 +1000, Dave Airlie via B4 Relay wrote:
> > Distributions that want nova-core to be the default driver for
> > GSP-capable GPUs can set CONFIG_DRM_NOUVEAU_BIND_GSP=3Dn; the
> > nouveau.bind_gsp=3D0 kernel command line parameter switches it at boot
> > time.
>
> Just FYI, we've already had to scold two distros for blindly enabling "CO=
NFIG_NOVA_CORE",
> despite all the warnings, because "that's just what we do".
>
> So personally, I'm not a fan of CONFIG_DRM_NOUVEAU_BIND_GSP.  I would pre=
fer just the command-
> line parameter.

At some point we need to give the option, but indeed we don't have to
right now, if nova developers are fine with always providing the
command line option then we could drop the bind options for now,

but I know it can be annoying for devs.

Also distro will enable new things with no warnings to not do so, but
I wonder should we do a default y option of NOT binding nova for
allyesconfig.

Dave.

