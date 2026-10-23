Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C3606A940
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g80QoPQd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6261210E61D;
	Fri, 23 Oct 2026 17:19:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72C910E61D
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792775953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCry58Hu1bv8DzSjqRIxh17FqFhYo6FkXUsOocnB8WA=;
 b=g80QoPQdKuhwF6083tenR2yIUZCL+ITgWOCpeqWU2jiRPmru5BxoIXMwAz8KCqvvqf8rzJ
 E7hLYQQlGwAR8eCZZKsko2xa5Luv5wH+CYBeWGGPOxe4H3tEBbpscOou4cH3/07Hu2uSh8
 3Su44oLV3+ZSFgAEs/GkT4NtDtJs8Z8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-nXdg4A5BPTiwuHM7l41qug-1; Fri, 23 Oct 2026 13:19:12 -0400
X-MC-Unique: nXdg4A5BPTiwuHM7l41qug-1
X-Mimecast-MFC-AGG-ID: nXdg4A5BPTiwuHM7l41qug_1792775952
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ce7a85f04so222683885a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792775952; x=1793380752;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iCry58Hu1bv8DzSjqRIxh17FqFhYo6FkXUsOocnB8WA=;
 b=T+tx4JitX2D71GM7AGvPKVdnYEPrH8SJnRea6S6DaABJBoIKeD7bDPYxEuPyGk7acT
 44DTnQxQp69QFbF5RVj2m6/XhUWPXbL7jlQi9X76DBjE8AKgQSZyyke2B1y/4B0ET2aJ
 FLIFwh4g05sGN0UMoRaN34Czg7c50n35w94gnIDNmWqXeDQNtkCvsAfjCo+HiGZOvzCM
 HLDYA655TchaVzRg1Bpzy49HrXMP4wZPVGx/NJT3zxsdtHY6+wtI/U2zYvi8leqvFZrP
 +eBjUyveg9pIjpXgDFJ5abOZ5EgBY/OWtfP0Ek+3Ee/uWdZTr9uZfRLhuw3kxQIzlxwF
 OpIA==
X-Forwarded-Encrypted: i=1;
 AKwUvByV1wah3DG3CffXrulkNJQjgb55u8kCSot3aWHJrsV3jgd06TDsgu4BPeVxG7M44KnJnHfCEH0mPXE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLUvg8Yi4g1PMAkQoSb9AYuMiOtwKhMC8cnJdUTWn4+p0NTWCbM
 ud2J0byT3By3lhWaUFED9pJAUK+zmb6IGh2cBRgKRjgOAr1ovY9DI5ok5nicb2gGkz5hFUI/wxt
 /Kao4abJmfLxoxXjh43a7GViEnNVIAvihbJouDi2Q4cfY5s69fPGhVvaxXgxIVkhp1EZUHw==
X-Gm-Gg: AYBFou1sAFzTDWNCRlyGl2H3kLb3Dh4Lc1WqO6mdH9q1lN14j2jrAsq2u0HeC/d3q4J
 sXDm5ywEZuqFyPwKfstbfTs5hK+STFZukUW7OwJCUH854cg83r7TVlW8pM1tTbGg0UKkRRd2mu9
 SkO6BeIacw1cfAk7dtYGKElAitCNGdejORzCid08w1d3HwH5HU3uSJFCYVl1rSPfTQdLNIYn2t9
 3LXrXrJbs5KEwGCJuEZXIC+PMEO6WRNZBj7K/EE0Gu5s3hGp09PbbWVVO8ZuBQYqhsucZOmRu2X
 R+5mgEueeDCPGnVN7J6SZfv3Y/YXCcLyaynnL8AD/g2AWjk24HF9mg8tQayetApKUC2zAHQ=
X-Received: by 2002:a05:620a:1a05:b0:93f:2b23:4820 with SMTP id
 af79cd13be357-93f6f7bd38emr559076385a.48.1792775951965; 
 Fri, 23 Oct 2026 10:19:11 -0700 (PDT)
X-Received: by 2002:a05:620a:1a05:b0:93f:2b23:4820 with SMTP id
 af79cd13be357-93f6f7bd38emr559072085a.48.1792775951481; 
 Fri, 23 Oct 2026 10:19:11 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9404722f226sm70474385a.9.2026.10.23.10.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:19:10 -0700 (PDT)
Message-ID: <939ee9cdaa3a561f5910fde2e4efacc8c92fd39b.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
From: lyude@redhat.com
To: =?UTF-8?Q?=EA=B9=80=EB=B2=94=EC=84=9D?= <dilddream31@gmail.com>, 
 nouveau@lists.freedesktop.org
Cc: dakr@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Fri, 23 Oct 2026 13:19:10 -0400
In-Reply-To: <CAGC3ukSVk=N4ttd3hwnXXXppHchwroJmySPAFP65Vt+uP0COOw@mail.gmail.com>
References: <20260928081450.19340-1-dilddream31@gmail.com>
 <CAGC3ukQ7gX97E7pG0Oy8H0cnmQzoA1038io+VhrBogPB3y9dDQ@mail.gmail.com>
 <CAGC3ukSVk=N4ttd3hwnXXXppHchwroJmySPAFP65Vt+uP0COOw@mail.gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OVNpXAe7rb3VW1rl2pT3Ut61wPigA34Xsn2E3VM9r6M_1792775952
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-10-15 at 19:40 +0900, =EA=B9=80=EB=B2=94=EC=84=9D wrote:
> Gentle Ping.
>=20
> There has been some related discussion here:
> https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux=
.fr
>=20
> The patch has also been independently tested, with no reproduction of
> the issue reported so far.
>=20
> Apologies if you received this twice. My previous message was
> rejected
> by the mailing list due to HTML formatting.


It's no problem, I'm going to try to get back to reviewing stuff asap -
currently I'm in the middle of moving however so I've got to focus on
higher priority stuff at work at the moment. So it might take me 2 or 3
weeks before I can start reviewing stuff again
>=20
>=20
> Thanks.
>=20
>=20
> 2026=EB=85=84 10=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:10=
, =EA=B9=80=EB=B2=94=EC=84=9D <dilddream31@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
> >=20
> > Gentle Ping.
> >=20
> > There has been some related discussion here:
> > https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordea=
ux.fr
> >=20
> > The patch has also been independently tested, with no reproduction
> > of the issue reported so far.
> >=20
> >=20
> > Thanks.

