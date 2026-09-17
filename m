Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D485CC982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F15EF10E29C;
	Thu, 17 Sep 2026 12:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmBfC6DO";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F8210E29C
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:22:38 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so4399615e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789647757; x=1790252557; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p0zmU2W+3BnffNO8O4v0JPRgPOvlhktXL05mpLnU1xo=;
 b=TmBfC6DOubF1DKYt9DOZ3OVha9sphTE6pOQRR+GLa0AHJCBtxFFvujCfPylC75UwdD
 9gH3YZHURAa4JN+c4DWA5r5X41KVKKT4faiEBJEWXYMzBD3uVPr9g7FLqDmACKa3b2En
 0GgoaV1xG8xeZPjF37kQbFnab0mxmBsRU+4aZmyaCGC9tn7S1yBgUhhw3hmEbDioey6K
 XsejVoGkWI8OoLp7pp2EDAYrosukkAHL+vMgrZMq+s7N1X7HFkgxBwfAmaq4sYJZWfwr
 X1ZKWjth4GF6VhqgCYhVMfpWDv//eQxaxmLUGLZewil+bJEZvvtfCV9RAxxWpfvTCbjg
 uzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789647757; x=1790252557;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p0zmU2W+3BnffNO8O4v0JPRgPOvlhktXL05mpLnU1xo=;
 b=PJ+qSUZDL9Zaru64EwwYFgyUBnERV3Ov+VsB3vgTeKu1oU/nyo/WMbWXO3uaitI5A+
 LvcgLJ1sqg67W+E3eGXDIccmv+fBJAYgD2VJEkI5N9V/2FjtOKYGgwtAatjh2+1BZ9r9
 Y8UiQfUEfF9EpbStrf03plGtckX6+JBPVYO/XF/TdbVBtSCXF5nxUXwroml6zH+mtgtV
 jRf/hoO+rhbcyaVZq7w+QBTEbCDAG1BmKJN4YP2ru8DSv9mHEv++BqNIJy98n56TQLHl
 wdd5IKxJwufQ6MhqZI1tLj0K9sGkGly0CVtPn33V1Zy6QRognonjfkEsz4kuiHI2GhkD
 FhMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNOSuKrn8h1FFGW2+49URGLB+kqFK9tdaeicJKYt9MCRe9nL/7wGyIkL5tSh89v8HlNRL5eGtla4c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nCoAtSUzn2bfaLhzSHFK2WfLhQRRp1e4lvZQsiPtayAMj3XfKh
 aAv4S4J0Eija6tfrs/ePpD+a8wog6F9B3dUp1zyeG55We5locHWIak2X
X-Gm-Gg: AYBFou0E84RhkRxuFjY0DZCop0tdNJnbfcVQ17zFtX9W9S97/cGWqauBhBlijS+4RyJ
 5EjD9tidlxRtI5KY/z4+9e92EaEg1S/Y+RJOPBqQB3lQHS44RpTV7JP5jHCOLPNz1PtrhOA3AJe
 e2DvGZjuauf1V8CK1lcWnV4+kjxG/Q1xuqx+wQyxevPU2FgCxzqVGGhqKZNOKNMZXMwgW3Yl2eU
 3E83qzgFrjFqAmo/dBp8xuc20jGqga74pLuUf5EtXbxq6hZy1booN7Srzwra6Qn62mY9/YuNIXQ
 EYpcNZQuxXIWLVhX+YP2NhN9QAIYqTigyL33L8kNn4SQZ2kBcvRXm62ST7BJbRdg0HtZZWYVlG+
 axgBEyH0MhcuyZXcYjlp7evQMGcPeNW2tHHNJGahn3Uo9DJLaMRSKeA+Gkw0lXZ7llG7cPCIYtF
 KQnf9tA/iY2z5KIoTt7qD+bmT2rPbqFC/0Zf/E+sOXrLYMqXwXfW78r0Vwu87u0+O5/0RdP1TIa
 3nSpnHDtXSGWQ+/38QE0vMjPmXfLipme8D4
X-Received: by 2002:a05:600c:4ed4:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49eac462571mr73688225e9.2.1789647756735; 
 Thu, 17 Sep 2026 05:22:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef7678sm15969081f8f.2.2026.09.17.05.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:22:36 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:22:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, wine-devel@list.winehq.org,
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] file: declare the FD_PREPARE() variable with
 __cleanup() directly
Message-ID: <20260917132231.26314015@pumpkin>
In-Reply-To: <20260917-work-file-fd_prepare-v1-2-b87534ca49f3@kernel.org>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
 <20260917-work-file-fd_prepare-v1-2-b87534ca49f3@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, 17 Sep 2026 11:09:43 +0200
Christian Brauner <brauner@kernel.org> wrote:

> The whole CLASS_INIT() detour isn't needed. Use __cleanup() directly and
> give the destructor a private name.

It also makes the code enormously easier to read.

David

> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/linux/file.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 2b864f457211..926cc58d0b7f 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -146,9 +146,6 @@ struct fd_prepare {
>  	struct file *__file; /* do not access directly */
>  };
>  
> -/* Typedef for fd_prepare cleanup guards. */
> -typedef struct fd_prepare class_fd_prepare_t;
> -
>  /*
>   * Accessors for fd_prepare class members.
>   * _Generic() is used for zero-cost type safety.
> @@ -160,7 +157,7 @@ typedef struct fd_prepare class_fd_prepare_t;
>  	(_Generic((_fdf), struct fd_prepare: (_fdf).__file))
>  
>  /* Do not use directly. */
> -static __always_inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
> +static __always_inline void __fd_prepare_cleanup(const struct fd_prepare *fdf)
>  {
>  	if (unlikely(fdf->__fd >= 0)) {
>  		put_unused_fd(fdf->__fd);
> @@ -199,10 +196,10 @@ static __always_inline struct fd_prepare __fd_prepare(int fd, struct file *file)
>   * @_file_owned: struct file to take ownership of (can be expression)
>   */
>  #define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
> -	CLASS_INIT(fd_prepare, _fdf, ({					\
> +	struct fd_prepare _fdf __cleanup(__fd_prepare_cleanup) = ({	\
>  		int __fd = get_unused_fd_flags(_fd_flags);		\
>  		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
> -	}))
> +	})
>  
>  /* Do not use directly. */
>  static __always_inline int __fd_publish(struct fd_prepare *fdf)
> 

