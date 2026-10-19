Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D368606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GWrXtnmL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9961A10F2EA;
	Tue, 20 Oct 2026 07:36:27 +0000 (UTC)
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C8A10E0B1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:46:43 +0000 (UTC)
Received: by mail-dl1-f68.google.com with SMTP id
 a92af1059eb24-1438d9363fbso277588c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792399602; x=1793004402; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=R81uGUDBlkE6/NsZn54/pArgBx2k2sR0sHNuKkRuNRE=;
 b=GWrXtnmLmBcdNgXCDzHil8dEHWk/n+shuQk5uLmQtHrJwxDBdiHm6fnTRHI5a6jedv
 LkPzn8xqOrPSFHb7VKpZTAP2/1a8dlfFaaKbacvjkWJ6AlPex+ND3IO1YwtsSjxfbNlf
 lRJVpxrQ84wLhnQONk/z0I9ksNMMmAJuKLsB6xzAL5C0Ne3tFXdWI3M2sQ0aRQJkhp/0
 wmQ7iVuJwyAtDnr3tJswK3Qkjd1vWcMeGxmE7oD38w1OlSoV04wtLOW9dpjn4A8mB3aI
 bWsdQ8Y0I6Jkgc3Bm+L8QnCUHsAsz+sN1JqJ3xEGQtGVv8Qa1sAs35O+P/xIJyXA+pB0
 TMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792399602; x=1793004402;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R81uGUDBlkE6/NsZn54/pArgBx2k2sR0sHNuKkRuNRE=;
 b=qfckGWjkMiQvXbWd+Sb9XKC8Ct2KO+0L65YF4EPFnZHX6NaFYL7IhHnHY17mOSceQO
 AIDxA+CKa9iU4pepBwRy5X4ee6tUI/lrYMMvuqHqJmvVzYkc+rGO8Qs/w/Cs6wfcuGNn
 VYQRVzdsSh/Ar0+wE79xld+en0rHaLPHtb8OrunlfgOaLTt7yuyPA4oYkacnJRfaMnuT
 B7LZnsjNYkdpaN8PEWWmUeFMQbwUWc8/QexhoFuHeW9elRJDduSXGkbnWuZ8tizRKIMe
 V4me4CMfC+N7ei7CeaIevmWD9cbswVX1DFSgHomA/a7y1Zh049v/1/MAbllxutoavm84
 tm/A==
X-Gm-Message-State: AFq9FYKX+w9eoimlXByRwguKiPOqdNGgJlIeY/QC3gZvo4T3UDHBzggF
 Npi6MA50m0Ri9+lYbTHANpfnGDu16tB4YwwgRC4F+DobmXQOWmYDtDQv
X-Gm-Gg: AYBFou1Rn0new9K0QAbVB/QIrzeelgW1A7QFeZmwJdGGQOZvIFSofqgj0TbVxK2bOTY
 1oE6kS1s6E+fBA8YUtv+ghz9K0nXhjX+1U35hh5rvv8WAszWfwQ3BgCm/xRuL9XqbEoiR+7HP/d
 gSd2mcR3jrPRa426CBCRAvRx/hACTX2caGVSxhmytbZyFf23Pm04rVPrLf+nW9DRQq1+LK07Yqx
 JhAWTseHsWKAr14GYvK9PbWobgKI3xyOuao1FGmsgwGpXjI8i2D1DeshSbxDXmhxfFORVjlbPTL
 PjhsqGDijbizMa1Ut/btf2eqp1xQll48BpErj3O9180V7nAhE8Zl67pNppn86UVCl4DGwKf6wu6
 DSJJocFKb72mbx0qIpym+XpH0HozC/p9CW4koRkGAwHazBd0LQDJthPqEpJO0miSaEEnIb/nRmm
 69ajproxjJGTcDqKhPx7/jt760mZvN8T8JF2HfPMtLnPQ8DBKV5ueb3AHScmjencgENWUMpPF9c
 BGJtIK3USmVm4GOKD69LQ==
X-Received: by 2002:a05:701b:2092:20b0:143:808b:b178 with SMTP id
 a92af1059eb24-1825c27d1a0mr14024480c88.26.1792399602431; 
 Mon, 19 Oct 2026 01:46:42 -0700 (PDT)
Received: from blue (104.194.64.109.16clouds.com. [104.194.64.109])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360826875b3sm32116751eec.21.2026.10.19.01.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:46:41 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:46:37 +0800
From: yyaqia@gmail.com
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, 
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fbcon: Rebuild rotated font buffer on font change
Message-ID: <atHdEJjrSTrlZtSU@blue>
References: <20261016073023.490430-1-yyaqia@gmail.com>
 <20261016073023.490430-3-yyaqia@gmail.com>
 <3382a02c-ed79-4214-99c5-dc81ee59d633@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3382a02c-ed79-4214-99c5-dc81ee59d633@suse.de>
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-16 09:59, Thomas Zimmermann wrote:
> 
> It's way too long and boring to read. Can you please try to shorten the
> AI-generated commit description?
> 
> 

Sorry for that, I was a bit lazy to think commit desc by myself. I am
new to kernel and a little afraid that my message does not cover all
things.

> > - Also select the blitting type again in the error path of
> >    fbcon_do_set_font(). On tile-blitting hardware, set_blitting_type()
> >    uploads the font map to the text engine; without the second call, a
> >    failed vc_resize() left the engine with the rejected font (found by
> >    the Sashiko review).
> 
> The problem is that rotate_font can fail as well. Handling that in the error
> path is not possible; hence results might be worse than keeping the rejected
> font.  Can you try to keep the original rotated font and reinstall that
> directly?
> 

Good advice, I will fix this in V4.

Thanks for your review,
Yao Yiqi
