Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB09BC5DF6E
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B44710E2CA;
	Sun, 16 Aug 2026 13:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AIZyTRqN";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935AC10E2CB
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 13:21:55 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954c08a7c8so2414025e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786886514; x=1787491314; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vwi4ydnsAAyRjtAJ6OmNzoOX8cU0AryA5emhiyqpUtg=;
 b=AIZyTRqN1EIegFJDCwyjym+iLlKB0IRL3o+AtY3BSBXxNx8L+hBcvAk9Exrkr+a/UF
 XCDsgsnNMk/hZHePaK1OSE+HRadx8LsPkPUTpUROIdu9Rqb1i9g53fsrgDpEy2rZyBXy
 qhA/kMEGINkN7ElIxGS0w2Cxfs+c8jKgnfKkhauudxGnXo5YMeslI+zwObSfaq8z95jc
 pWXwH4lqftXOm3srOC7puVQgSdIHAyxQfMFHDaUGup/fajJSDttg6KznWOwLEx5OfK1I
 cdnAXz5V/MiIkGWWRLk/qBOGWuSEmtMd6Tw295bLYVZaaXerE1Mcp2mvzIhR6UBr5hw4
 oC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786886514; x=1787491314;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vwi4ydnsAAyRjtAJ6OmNzoOX8cU0AryA5emhiyqpUtg=;
 b=jgLEDN6AvIZGoNREpmuFmfcNCcxv9jk5hzlVtdjUMtOC4sx7QMCzdR/tHfHjxM9I38
 XrFpX1fMFjd6MlMaglhdStSnhqllCnel5bNEAsOeSXlD8ysGN/cqw6JlTpA7P3u6QP40
 Gk2mrgw77Yyo251TRFh30GCM3bz6zcqMTZd5tqNf63UDewjBFKGgMmI5pEBY8Nwbt/kF
 i34A6mwLmBZ3/N1zCCgdmbBu94Ehu13EeFTnOH9JFhdjgMJFSe616VtS4UjGuAEqjcir
 F+WjX/APv+VW7nhoWz8+WaNVndLPZLac4zh6zg04QMxn1r1ZQG7M76n5EDHFAixITCHe
 9Xuw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1bfA8Ct+RE256Wnyf2LBH5dw+nQ3CPk/ywhkOfXFb6D6+9n3Ap4ofRoRebSlzx1r3vB9iuUbbc8M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxn9gPplAvAXea1o9rei0TR+VliT6DKtsXXkeJ18wtsY/aYmCSb
 NBf17uumSB/N0UjmTF65EN7xX4z7HiKta+jWoIgbY4J6+w/NTUJusHqhXWc6qjKS
X-Gm-Gg: AR+sD11fol1dkQ9nFpX1CiSsSxyJC8C0Nw7bxcOoWzHZJjaErp8y97++NLhFrZDQCGz
 WBBuDD/C2UXqyyPcT6/hsWhvktkWDhXdq8HWr0xx5SqZ9jQ3sIgPWzO9e2mmQMxaE0cwixjUqtN
 t/F1VCR+COwshgG0UIu+EIYvmC+hyohv+VfV8fdkT7eFNpPDbmkEGKFW5HI9mzVPBC0F3J9VVT9
 P4xQqvshdzdphI7pC1bMpDWqmbJqM7bkEeFUCFGRFffIiK1korNDHZnXUmDBTJJpo5GmUIvzXi6
 sR6ymy3zrd+F/dL41ojhR6GnczqC8nbE3alAqOB8je2TYgdBFjydsQvj0SLfgYc5kfw2GA+Kssh
 F6hGRnjgugiwZO3G1VE8pTRuGt8I8NmgS4DFIbBiUf3zWNSlfKdiYXXr4UiTV6FLhP2/LRWF2u3
 GnKBF5qcbA0uUeqCyod5N6Hp+FrxlcipOoYxJHk8B8GUcP988WxdsRIQxgQFxVqkEmEgG4fIrnK
 F2pRvIk9/ec3GzXTfHcKQ+jWW+FQBIo68r1OgQdBg==
X-Received: by 2002:a05:600c:1395:b0:499:77de:78ba with SMTP id
 5b1f17b1804b1-499879826b2mr135612495e9.2.1786886513900; 
 Sun, 16 Aug 2026 06:21:53 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1fb7sm24093936f8f.17.2026.08.16.06.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 06:21:53 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2] drm/nouveau: disable the fence uevent work instead of
 just cancelling it
Date: Sun, 16 Aug 2026 15:21:52 +0200
Message-ID: <178688651234.533102.4891184749713137564@gmail.com>
In-Reply-To: <178688513268.513871.3468844663561639695@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.12779628082366287968@gmail.com>
 <178688513268.513871.3468844663561639695@gmail.com>
X-Mailer: python-smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

One correction to a trailer in this patch, before anyone picks it up.

The Closes: line points at the cover of the series the bot was reviewing:

  https://lore.kernel.org/nouveau/20260812231330.705425-1-mczernohous@gmail.com/

That URL resolves, but it is the nouveau view of the thread, and the
bot's replies are not in it: that view has five messages and none of
them is the report.  The bot posts to dri-devel only, so /nouveau/
returns 404 for its message-id.  A tag that sends the reader somewhere
the report demonstrably is not seems worse than no tag, so it should be

  Closes: https://lore.kernel.org/all/20260812233022.159301F000E9@smtp.kernel.org/

which is the report itself:

  "[High] Canceling `uevent_work` before destroying `fctx->event` in
   `nouveau_fence_context_del` leaves a window for use-after-free."

That also fits this version of the commit message better than the cover
link did, since the report says use-after-free and so does the patch now.

I can send a v3 with the corrected trailer if you would rather have it
right in the patch than fixed up on apply.  The diff is the same one
word either way, and it did not seem worth a respin without asking.
