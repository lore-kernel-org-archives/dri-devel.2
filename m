Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143E1C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EC1A10E673;
	Mon,  7 Sep 2026 07:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nEnHHzIq";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979CA10E43E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 04:24:15 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so2081606a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788755055; x=1789359855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fBu2LuPpjoahvMmaWEwQMcGkzlxXBLBPYT/w4A9fsYA=;
 b=nEnHHzIqXzsjwJDJZCtKHpKLlKSlcJ+cramyYWo9iHghNcOq3swF/DWMNQgZvsbXKr
 AGEeMAIKCqxvIqw5w9RtA3/n9pOmge2EF/tBWf/45P96ttMttzeDvZIOJh7aEHeJ9uGU
 eUzaSu6CwMeFEcS1SpO/mk2KzCkDKkon00g5+QqauzljnbR2QJubiOMC0rgwihv4dW6m
 8A6iw5lG29cV8dP94yaOfr3ADTYqoyfORe90+N7gkaCMFm4KJZZUEyDV/E4LZ1OUijOi
 UmssLNu9GIktY8x3Hxko4BbV2BZBUSy5dStbvuCT4r6/b2JvOTWYttOaqCXh455+Nkpy
 LwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788755055; x=1789359855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fBu2LuPpjoahvMmaWEwQMcGkzlxXBLBPYT/w4A9fsYA=;
 b=Id/lEPOHKGWMbv/VTaHFPZWFDjZhz5Va1nDKU4MeRg7mzyxYgrBK6copKVcupkqKby
 EmygpublzqlZjxKMYBaB1UldveKwde1aOWCC35GHBWZ7TRVGyDBEad8CVMPWNdCRNxI7
 GnZCR7g9wpZZadJbOwFbK/tA1xXYm2QoMqLVTUxet2I/gCNZCcSIAYPN2PpM+oqvkkgZ
 aljPG5VEuO9Ue+oQhaYfn3nVQRmJ/qhR6W65f4ophUkssd3VGcdYJxcD7ykbOWrXhY5G
 SiJuc5T/uZnCTTE0US1dsP6chTX3TJM6kxFBu6hNIwGk+ygN8Nxqd4TctRai6gYIckIr
 lnZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcY4bEN9/AMB4OVZakSCuagxKZ8BHH7RArHCTaotkWwOekbRjUxU2GWVjtpajr59ZBGqSfp2hD1xY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kjzD2qGepRqYsJ5WMnHMj1ExVeZeJZdcknmHtScpjdgUW5JLhw
 2jOnwFOx4GnnAUHSt/roKw0sORbxhUBFT9cTRPxXnHJQs8l4+zxLF7QP
X-Gm-Gg: AYBFou1U3n0oFjWNXJSjLfka2/uRCYbzG8qgrCcG+TDPqJTCsOQ+US4eJin2Mi1rLjS
 CoP5g5+n2VkoIiOZO8zn9O5xZ8poaSEAMAMlqHR0QnqXmuWHkrnzsXDTn4+acJFs7mrTomBpufq
 l87DOViUNtnQpeS6c/NzqQVUmAJGkkdmyr6rJOO06xCN9qSqeU4DuKqVF4tY7nHEmn1zdhZza4Y
 j4S3GedmiIN3rUtf9AIsxOp7ea4CUKN6lUftS8LfAeeFOWAAyvWx0vch3wDctQW/2TwXsYoHNmF
 BYPkseESuqikg/fHh1ZOBYzFTVUFRrnQ07CmieyloUVMc+tQXRXimjNiTtBDBYuR/3zrGQ8B+gL
 eWbb8TLuRbIAWeY3qQnmjxGQbT4P2AugUYv7P/tluosZXQGkbjDb7kf3kpcOfoxiENLeVMtEu8+
 ifE8magiwJd6l7XTJR/4zclHA1jVM09iahMJUlB7WnQ/huSu1M5W9iceGCG3XgDWRNzrDVhMt3W
 CLmaWEPyHl/rsk=
X-Received: by 2002:a17:90b:39a7:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-39b26125efemr29120236a91.10.1788755054931; 
 Sun, 06 Sep 2026 21:24:14 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3342af0bc08sm22629643eec.17.2026.09.06.21.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 21:24:14 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm: fix repeated words in comments
Date: Mon,  7 Sep 2026 09:54:00 +0530
Message-ID: <20260907042402.12893-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120430.17224-3-hemanth.selam@gmail.com>
References: <20260904120430.17224-3-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

Thanks all for looking, and point taken on the churn - I am dropping this
series and will not resend it.

One correction worth recording before I do, because it is a mistake rather
than a matter of taste:

  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
    "Add a view and the surface it's pointing to to the validation list"

That is correct English.  "the surface it's pointing to" ends the clause
and "to the validation list" begins the next; my patch deleted a word that
the sentence needs.

Natalie is also right that the dmem hunk is already fixed by 23df2e995df85
in drm-misc-next.
