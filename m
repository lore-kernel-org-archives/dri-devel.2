Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E647C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A203210F10B;
	Thu, 20 Aug 2026 17:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QCC1CY6y";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE05110F10B
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787246945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2THSxdc10N3Uu73ngO9PWmoQr8ld0v1dmliCiNyRQnc=;
 b=QCC1CY6yx+fjx16c16ai4/2rY0r4qn5fjEx8PoXObdP2KdZuZSqDu8tE88EotQ14uHRd51
 ecbmWCM8pOq29cXcZi++fdMM3Qiu614Ugcr3DG8AAfDEyEL93WE41UxJ2yCpfSeCyUgZlS
 CDVZfSC8lgauNBu3POWRpljAgF0/0Eo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-Wo-eNjQrPwqeBX-PNeQSkw-1; Thu, 20 Aug 2026 13:29:03 -0400
X-MC-Unique: Wo-eNjQrPwqeBX-PNeQSkw-1
X-Mimecast-MFC-AGG-ID: Wo-eNjQrPwqeBX-PNeQSkw_1787246942
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955d314945so470965e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787246942; x=1787851742;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2THSxdc10N3Uu73ngO9PWmoQr8ld0v1dmliCiNyRQnc=;
 b=cRTcMVUbI/qK6cvLigLFxIWv1vWP8XothR7fZHnyBsAz2F9MsdF064HS65vCYvltM0
 gwhjn7J7NGDAyRUByOPa3w9Qerj+Mq1t0F9uH3YkLQTtJaZRXDwQxo1KtjRXTOA0BX93
 XgUk0MsV1nLd4oiFk+L5ybppYsT9MMQ1sGNKUJTmyuGWEzhzc4Fcz5+tgIIRtYvRiTX6
 iz8X8CTlG3Wn8eQZAY58u5po2yAvPcfkiIXydP7KWapzUOaTPSRe2BwKcniEEGbEJkhk
 v2I+5oZkMdvP0Ai6+qS/zRDFuD7OEqdGqqwS7s3/b3H0nUX1s+s9pQt6CordGqTsLZfd
 yjVQ==
X-Gm-Message-State: AOJu0YzxJrOF/gIfOMJbh+ifetp+CjMCynDp5qGR2OIypd/2360mM0ls
 xFwTNG30Msu6dKhW5u/gYcrMBQWdrnd1LcQMDgKMnyR5v4CQQPFwXNpQRcGPkF9fgZ+5oT6tsUi
 JNt40yRkAL5e2DgpTl8QHPQOmZ7ofgGkLn6UTQ2p9wLG7S8tEb4GGBUcR0qDuaalSV5fciA==
X-Gm-Gg: AR+sD12zLNdoBtjlw/YX3IzNPYmce1eyvbFLSgG/QcAKQButqOzmpnhWp14I1eievw/
 GpDGl5NXKuQ26Sms6FnqKVxXohlLqSka0C7rKRTxn6wfbfhJz7eP4WfN+aDI3koFvv3D3cCd2th
 M2IpB6NK1w8U8rUzV0Qb1G2HRwg5QTQDdS0jgNYKjSs+DoBeXBdpkhKsN14p28C+i36tqCsKyqA
 2e92/3ZNVqnyFz89yXUXLqjMBF/5r+dK0GDbsbdUq/QMw5FyYu/wLOOdSFYcIMWYUnwTY2v5/2O
 CB9oTva5RYg7CQ2g0flFuD56lnjraC4OgDlcV9/cuMjtfAmVyMbDVwIEbH9HXRYx3MzcnIJF
X-Received: by 2002:a05:600c:a087:b0:499:a760:722f with SMTP id
 5b1f17b1804b1-499b8461acfmr9069185e9.13.1787246942164; 
 Thu, 20 Aug 2026 10:29:02 -0700 (PDT)
X-Received: by 2002:a05:600c:a087:b0:499:a760:722f with SMTP id
 5b1f17b1804b1-499b8461acfmr9068485e9.13.1787246941850; 
 Thu, 20 Aug 2026 10:29:01 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441c78sm14050312f8f.2.2026.08.20.10.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 10:28:58 -0700 (PDT)
Message-ID: <b91083f5f3b9448904a9dedbb1879463e7e08e37.camel@redhat.com>
Subject: Re: [PATCH v2 1/6] drm/nouveau/kms/nv50-: Move DPCD backlight
 disable into its own function
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Thu, 20 Aug 2026 13:28:57 -0400
In-Reply-To: <20260819161409.991131F000E9@smtp.kernel.org>
References: <20260819155934.154125-1-lyude@redhat.com>
 <20260819155934.154125-2-lyude@redhat.com>
 <20260819161409.991131F000E9@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Br9f9mVUW17Tbb7d6wirTYxGq77sPLzKnWxxX_qtMRg_1787246942
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 2026-08-19 at 16:14 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>=20
> Pre-existing issues:
> - [High] The encoder atomic disable callback invokes sleeping
> functions via the backlight disable helper.
> --

Hallucination. It's treating the atomic disable callbacks as if they're
atomic in the scheduling sense. They're not, it's just the atomic
modesetting API. Sleeping is fine.

