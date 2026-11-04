Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418D606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJcqz8A0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A97B10E888;
	Wed,  4 Nov 2026 14:32:45 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914FF10F1A5
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 14:32:39 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-5eac49ec2f5so37739e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 06:32:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793802758; cv=none;
 d=google.com; s=arc-20260327;
 b=IlHNQc6TLlYpwuhSS7TwVVS4W78PQqCTRhc1NxEyqQSrP69bkazxbb9wDUI47b0GtN
 uCShjDgZgb3HQSU/kIYDYMJ+bEmtqTh94v7kZJMrXJ3HyOYnqovOcCVzJjPZKBMLaoOw
 Pe4Qcjg3szi+Wh1+sOW2D/jyKqNUWFlkli4ywFCNy2SZYUe1n18rhz2xSsqOu97eoXkG
 unyEeGz7jHpNri38gFwiH2E/LsqIs3q5oP/451bVyaptMEr/EfC5u/WavYd9M393XCTx
 wKqtCROLW9eRzMMPXTwbbPTv41KpAWQ6iQmuDc4brVOhpAWpmdcFL/iFi8o7IMDDoaFe
 o5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rBCJhchK0NF+Gj+SXhOsU8rPb9pW7B64q/c4ONRSGCE=;
 fh=BowmfG/kwTMeTiwVmDBSljt/r9HmdSBK7IdvYH8OFiY=;
 b=KbmK6t8l6JbUSaidLG2fbPTK+cC4I7eFWk5Z20hzlqKPrdx5CGM8ee1iBgKzhTqZIh
 Tw4M9NvlXY1dgw1+IKH0OCiYAkKxVyNH94BsYKY+P+X8HlWN2oMXTsYJ5yFgj19iW/Fs
 gFljLsVoP1RIiZL+7a4UncYtApaXPD6Crt3o5hYBtXXCQNyh1uZqy7hUljTqUrAJx4Ej
 P2LT1ubd6kqDOPbvrHdCEIez5E01Jhc5gwqOX0Ear+ef5B/HdOA6W3/8jkpYhzudgsIr
 QaFev7Apmc7ht77x45g53SYwXECNkh8asneAaNMU7gUzYKg/H2banow/pc7pdlVkDxB6
 S03w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793802758; x=1794407558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rBCJhchK0NF+Gj+SXhOsU8rPb9pW7B64q/c4ONRSGCE=;
 b=BJcqz8A0a8s0Kjkkv0YhIDRf8cY1n+k/EMCSMEgOq9H9YQiK4b+bW3FA17wzJcONpX
 iQs13gEPNFVwcsHDsgBJsBaiD+UsCk1+3IvpvU74ypHjO8Lzd7xbU7ZdttQjL+Sh9g61
 glhK03sTesYmpkfY0dNKfGmoB6E6CVEWzUw9OOZIcQc3G2BdRA011ZS1IXky1y6M+7kI
 9pZUEKteTnr6lm4QJWv+kQFiSKOzPgvjgJ3oPIUe4UV29M3mSpARMemByCFXTa1BSTed
 Ovf+Opml+/6HCnsmH9AYnPK2p5PuGQz1v4xSdb9wJyyAPvDcvuE8ba8XKjCtcPsTbOmv
 uHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802758; x=1794407558;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rBCJhchK0NF+Gj+SXhOsU8rPb9pW7B64q/c4ONRSGCE=;
 b=kBsyMU5i9AisWmMSylP1ELUjH+4NAMN0cTRWYRuDZkxNSjJrTJzvLeElkahLrQyled
 eJTt1gP4banjdLf6JVYR9bUEUXrmSTJuM4mBRo0f8pRPn/jqbpRIH3RXd20AfzJrNyGZ
 GJt1u2IbPBnrpJLSGu5oN8TrEIc0KjbV25i31c7WfyNzEmeWeZ5KaS3viTztDFj7+fMQ
 zveqU8UpE0QPimAfcl5WvIeBb52/Fvoq45MG4mWeFN/szkJo4iaqvSQB1GklhEdPuD0L
 6iuK5Vzpg8U/iBntM6Y7mPkw2VxLXrBtiYLehUrn86S8iaYM0JM8EjpiTs84fvwR000X
 1VnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxqiqch3eQ5byKw0rl97oAt5sBnRqM4OtfObFeHlIobrfyQN1rtpq6EB/m4CJ/MqvEXRj7U/MVUkA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/VeHnkZ/teO8lFlby1gZiy8g8PRgngYzfq4PrTggFtA9YFnEix
 5tMGhnQQ07GXgm7CI8TGEEDjjeuK+dA8gjx381pZBH5lQVcndn8WFt6YFYEt3dE4EPwgPyMwM75
 6h8NfXxPjRFzHqoRF6OpfH5fNjtzPxMt35g==
X-Gm-Gg: AYBFou1HL7EPll20uXAQ1v8rIGlhWaXOVqQ7uDciauKzzDW4HsNgkAbZlawbH+iVuzX
 98C3BrH3XK+UbiCKbx5K7eXQIpDIg3Zbl2J94d3HzKA8Grph/HUF20UKQ2G0p6EjGvOoLoFBi6k
 LL3Z5HxYhn018MPq0ETjQosxDNhMEis+yaPJJrGcrwtDfUR+BhfiGGxxnuOMNhuKmz34QNigsu7
 4JGJ1qyqz5bvypg168xWI3mbCa0+urMMeK19YxtFx72CMQPXMyVYLh16ZoyvltZBWQgQQW5wc2H
 elqDuOx54kWoM1ipUqSocX9CnBaSwQmXqmSAPwvp+vVSkbuAjIiaSo9/hrOM63FxL9XNhPIT3+U
 h+SZ38xl0RRmPlHJdymt24EGemtpTWmi5xM/4vCD8FsgawL0gjoJcca/fNPDAqJJArViGBrSYN4
 2OtkIE+yqHMx541OKIYHbQx/o=
X-Received: by 2002:a05:6122:11ae:b0:5ea:af6f:16e7 with SMTP id
 71dfb90a1353d-5ec689382bcmr7635405e0c.4.1793802758252; Wed, 04 Nov 2026
 06:32:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104024754.166260-1-abo@medichon.fr>
 <0566b969-cfee-444c-8a94-5fbb42859e07@amd.com>
In-Reply-To: <0566b969-cfee-444c-8a94-5fbb42859e07@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Nov 2026 09:32:25 -0500
X-Gm-Features: AclHuK9ldrrG9D5KOFB1JvP4Sf7ocCzQzX9d16vWTCBxdyyw6VsOZNy538gY8us
Message-ID: <CADnq5_PvQ+NPJ+nzXD34FJuLpa+rP=qA4ZOdns3QqBaJiHpzRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing parameter documentation in
 amdgpu_ttm_map_buffer
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Arnaud Bonnet <abo@medichon.fr>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  Thanks!

On Wed, Nov 4, 2026 at 4:41=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 11/4/26 03:47, Arnaud Bonnet wrote:
> > [Sie erhalten nicht h=C3=A4ufig E-Mails von abo@medichon.fr. Weitere In=
formationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnA=
boutSenderIdentification ]
> >
> > Commit 48c4aaeef621 ("drm/amdgpu/ttm: Make buffer copy source readonly"=
)
> > introduces a new parameter @readonly in function amdgpu_ttm_map_buffer(=
)
> > but doesn't update the documentation, leading to the following warning:
> >
> >   Warning: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:209 function
> >   parameter 'readonly' not described in 'amdgpu_ttm_map_buffer'
> >
> > Add the missing description to the kernel doc comments for the readonly
> > parameter.
> >
> > Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 0f86777250fc..d3a875a32af1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -195,6 +195,7 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, s=
truct amdgpu_ttm_buffer_entit
> >   * @addr: resulting address inside the MC address space
> >   * @vm_needs_flush: out, set true if a GART window was programmed (VMI=
D 0 flush
> >   *                 needed) or false for a direct address
> > + * @readonly: true if the mapping should be created with non-writeable=
 pages
> >   *
> >   * Setup one of the GART windows to access a specific piece of memory =
or return
> >   * the physical address for local memory.
> > --
> > 2.53.0
> >
>
