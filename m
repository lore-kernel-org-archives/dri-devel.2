Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A7606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I3vW/wMK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72A210FC0D;
	Wed, 25 Nov 2026 12:06:01 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1590410FC0C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:05:55 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so3557834f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795608353; cv=none;
 d=google.com; s=arc-20260327;
 b=CrG4Cw1pIZj3sCkPX+fbILfH5jSE/2m5OUF+7odZgebAb3aPNxoXcPloZDE2+9MgbI
 zdJ8CTz9vemnF2kX/uRPAQiMM0tfdk02ov93KwX2Pc3kduSU9mLQchUhxSjAWyMNkIcc
 u/p39MHmWkq8iMtqovXxH3YBhutTZ/bbf33or5MNQopRpQ0SfPKUDY3UD1I5WgVZLrHR
 gmEM/byhx/fUphedhH+pFnx8Op+zypk6g8Rdm+RrClQjF8Gq2U69d0ZPXhk0sXRZR9Zi
 KSi/781AmVLfO5U4RK35Gy3tyQpMX3KYNoq3kMZ/Gd3NCoBTxt3dA3afPk/D6RJAercv
 drrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mmpzCTGF7idKvkeds9ux4PCjDdw81921HPWjTxWauKM=;
 fh=o5zwEBdmwL/qIbjplNkVuezJUAhYlKtM27PAV/GX7aM=;
 b=GbfveW4uhkQDF49OEHv7Bt+qFigFyYovHlEPw1FJvStOa0GqFY+KtLSfK3f2WdS9Pd
 wZ3JzmRfwuRs10sY+psC8ACEntsGUoQNL6/hsDL4H3psLUxLsx3vM7TU+0WmX59s9uhS
 pshH4hk90D1ULzY76p+PJEkz335Sl3QGfUMf62d+r+3wuY3pCYzR5dKh6Rq8fgIKsc/T
 VwEhqogUSMGNVsFChnPe2sM60nciq67jqx0wbTzHuRzLFlgyYWyyShyRLOuw+oSY1DoW
 wgOLBFd/7xPCIoccg2cnin6IlV3sKBXIadjOZ+EzJTsB3rZEvfMlFtjLgo+QUWXcHKpv
 ezSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795608353; x=1796213153;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mmpzCTGF7idKvkeds9ux4PCjDdw81921HPWjTxWauKM=;
 b=I3vW/wMK6nREWVSnNM68OApURRLynde0VyoL+hqZQFoYXs87RPoiI0yMGRFcHOEpiB
 LEQTtdSvwGVlYCbdY6YEOR3T9cQCa7i1Mes+UbXOg2jW6807wFedRhSwytTSRWcbK4m/
 HOoFU0/BY2JCvdLpGfpeWhH4NdM8fnOJ290258z3PgtE3bvzLB/YYG+4M7MR3A/V2SsW
 WqtIggSG1GgmgMIHoWa0zA9tqsnCmvFbV17qaHarQ9HAkGem3SM2x7Yb0oXXCVwQX/4H
 n2SGAdiaJbu5A2hgtGmXGFkxbMBruwgW8SJfvv7evcRMYhmID1HM61Yo/CG6+c8nm+fC
 Ev6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795608353; x=1796213153;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mmpzCTGF7idKvkeds9ux4PCjDdw81921HPWjTxWauKM=;
 b=Q1AgDaKjFCodm1lyYgJN04PriPgIkeYcq/aP2dleMlrkAFr7dzK0qfHTnOn+9pBDaP
 wr5Rn4CaABBFl913apI7DqykoDyLovkiZJEqQx11WVSjJySZKoWKbIpDlfT5uAnMa9oL
 cV2UoJmXnd//af32qZCfAzem45gHHkbcCDCKCSb+GWV/iUrnb0sdeCxtjaCE2L8ohqUA
 4S544uwJsw7CPqYKwre3ZD7S9wtc0Cg/bMgLpZCkO0XQNTltMh6742oH4mSHG6fDUiKn
 JxXneka6Ul4qCOzhk9QsMd3R9MsCVPf66VnNDJLtmQR4KCB9zOig/v2MXrbAl1Rk6/Yn
 Vsdw==
X-Forwarded-Encrypted: i=1;
 AL+hErFwHlIbNzqeU9hJfJYtZX/vzE43XXcbeHR7zy5H8Z4HPNMHSzbwgbH7QxYRMeII8ZZhZuMD/ixi6oA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+RYcmX+QWl3QY5DUZU9hR3HoSLLLSxt0oRqCXzC2WNOF/YRau5
 mQXJb6ZMUviyYmJE4CegsiUnokJzaIYAtoj+GNOTEQ+5vGpemxECBtDWroMzPsHKdkH7vts3fu6
 X6UfZMeXfs/H0/HaJxxaw0facocOBsv/EdGdz4T+V
X-Gm-Gg: AZFdTZcVpsv3KctGXGkFJGwj9l6mIjRBdUlPU5mr8GM6dZ+hr6spILb2LiGwLsQpApY
 wBgl2CgNh4c9qz7bxBmHlrix6XNVI6QxnUXgIwT3Zkx/PRm0xPdBV9K4kZfX5B7JQNjEpOLMgvD
 /wNmaV77SZt1AjuVYVjQjsoIUXhbw0i1XNz8vRN7H0JVP+/Q0l46HfatWAymAkeLQyXh3/Q/qXK
 wZq6E7p1SlExQveVOgn5yeQ89X5VNI9eTPd2ReuMKKII1lzL68zEhW9IrvD5W9+OU8s3UmTzX0J
 PU8OJ4hpbdMJGeCoEkr+JPe+/0Cnn7ro/2Xm0XdycShksa2ziMsXaVM2qASBHihwCGBTK3xiSDa
 wARtAGoVBa14In54O4iz7K1Pei3rKdZ6fNEKJIL0uios8U1WqW8cGcUyc3P3UJdtagGsBoO11xY
 bfVZAozxaC9xPzqifRrx62JVUpxQ+TvnvNdLA5i7fHh4Jb
X-Received: by 2002:a05:6000:490a:b0:4b7:80c1:11bd with SMTP id
 ffacd0b85a97d-4b780c1127cmr8568730f8f.35.1795608352904; Wed, 25 Nov 2026
 04:05:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com>
 <20261118-ordered-wq-cancel-v1-1-916e01f9affe@google.com>
 <2efd4eef27cbd033bae9e4f5d5ba30bb@kernel.org>
In-Reply-To: <2efd4eef27cbd033bae9e4f5d5ba30bb@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Nov 2026 12:05:38 +0000
X-Gm-Features: Aa3M54oB_Bc5JJabfyDqaJiI78UWC2_tVPgPCR0cvXKqYj-o-7hWp3ZKJEhfypQ
Message-ID: <CAH5fLgh7b7vFj4y7Pi-s2-4KuwUQg1C1HD6VdDTTkd+xRWaURg@mail.gmail.com>
Subject: Re: [PATCH 1/2] workqueue: fix cancel_work_sync() on ordered
 workqueues
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 12:29=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Alice.
>
> On Wed, Nov 18, 2026 at 05:09:51PM +0000, Alice Ryhl wrote:
> > +             if (unlikely(pwq->wq->flags & __WQ_ORDERED)) {
> > +                     struct pool_workqueue *oldest_pwq =3D
> > +                             list_first_or_null_rcu(&pwq->wq->pwqs,
> > +                                                    struct pool_workqu=
eue,
> > +                                                    pwqs_node);
> > +
> > +                     if (oldest_pwq)
> > +                             offq_pool =3D oldest_pwq->pool;
> > +             }
>
> @pwq still has @work queued on it here, so it's linked on wq->pwqs and th=
e
> list can't be empty. Maybe drop the NULL check? e.g.
>
>   if (unlikely(pwq->wq->flags & __WQ_ORDERED))
>         offq_pool =3D list_entry_rcu(pwq->wq->pwqs.next, struct pool_work=
queue,
>                                    pwqs_node)->pool;
>
> Thanks.

Updated!

While I have you, is there any chance you could look at
https://lore.kernel.org/all/20261119-rust-workqueue-v4-0-707c68994940@googl=
e.com/
?

If possible, once folks from the Rust side have reviewed it, I'd like
to land it through drm-rust-next together with the things that depend
on it.

Alice
