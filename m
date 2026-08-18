Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B91C5DF89
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D6B10ED32;
	Wed, 19 Aug 2026 06:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOYdgUt4";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1C810E9C6
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 19:12:13 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-6b13496112cso203770eaf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787080333; x=1787685133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DDn6ZSx/VJ4JkxGObsezWUSfLD8hf+VrXkbieuK1ppI=;
 b=kOYdgUt48vneycvJf9rr6MBTuR5Hd6US3F3fhRPUms5CDieMF8OR7EiOF5YD0nt9Ng
 BNKiuklekVV+S1fDg/MIniOqgCKKG752/N3AsS6UNOYne7WyM+ICdJOPMDU+73tUjh4K
 Ose6EICar67Ffh8ZPG6alAWbFchs7gVzWUN3YmlLHNAqq86HTLPGF4U/NMhpjFCwPTrG
 I1O0S7NAfkuHoXhesIg3AJAw9QwHukSBO+Ger4/FORp9fQJsabQObxfVKkyCKyzY6JRN
 Z+f66Gvhzv7DxXSDLEu5ITZ6PXUWchM4o+SrK5jBi/atPXZPzJCL3xidwElmqAWEFex8
 HWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787080333; x=1787685133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DDn6ZSx/VJ4JkxGObsezWUSfLD8hf+VrXkbieuK1ppI=;
 b=VTmf/B/jSbDlL/cDVDdXxs0H4IK2CwBSRp+w4jpyUroCgRzfIQWJp3lW8CkEuykuEF
 0cB5J+jUNErGwP8Xesb0huuTQSpuuRSI1nHQbRN44A6uH1MP5nOhvWauz0dppUzn3lDl
 z/AtP1l4MCsjMW49dCKb7PXxkOiNerQr2T9Ly3HWQHAEe4bYP/kDs+nPkl9gv6jpF8vD
 yJIkKXcHHBFmtszDa6f8g/zv230mLGvEUyl0jtyKvXr1aE1e1X1vEHV7kg6LNkSId9ic
 mNiJuuEBy+o74+8dZHQK5RI6IKqo3kzmf0JhYnZDiVXFnZa4LWZhzR8WOL0YkbbjiFvV
 ku9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIZJ6h3TlRIO9UaMLZ1KgCp2DsRKOlIP9kDufCyCfpG2D0slup9GvsZz6hRUFQ8Ri1pZ12hyNszSI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOM7Mc1j/XqwZOXZnZNYlQ7nx7OauWkTsKyzk14cO1nId7dpux
 gAtjxrYiWo7HFPWUXcA3DLL/sc2tCqYgFBAx2D/bSg5k6VDEcpfoqmKN
X-Gm-Gg: AR+sD13UnqYDGoPBcpHF8AVE2dViX3QhMlbUGXzKpbuxqu3xNyhsgfCmTrivaT0MpaF
 jxZ+OymrsOlJlV9Rw89hNwBV37Xcn87CH5JC5k8jh0zYelG+/zLessRQYCsV0t21TNa9C59p8Y9
 xSJZJBxbObuSmjIx2Zpdy/jseN7bqceTRUoZZCATNTiKDeewfwJGgJO40QI+qPFrEehtweadWRd
 LBuyrWSVlPKeTCLctZ/PcdL1ywLeu0kK6cleAgsUUSDCOe6U6ovNuLvBjPYJ1+32Czo00zxhrqN
 yYrJVCb5FG7RbH47meTOEl7eV9B7/s724EPPbOH4j7hiF/l04Ja4cTKZ65e+EIeuHMV5CZXqIec
 XhhvlIahjh2GZuftOL4/DjR2QunmhB5irMlKPd7XAoN5HDDcgwyZ6Q0MWtyez03reEZDRG3uIBk
 l1iw59mioeTTBprIHD6sLx+92BBbwnaygasKWbe4b4VU8zRkf2eX7WYrORckcUEjByEYL4HJj9/
 r5+8Kt0dwAdxc/9gDubjCdabW+xWonGKolR9RKD1w==
X-Received: by 2002:a05:6820:f48:b0:6ac:abdb:7f99 with SMTP id
 006d021491bc7-6b11e202b4bmr8845680eaf.28.1787080332537; 
 Tue, 18 Aug 2026 12:12:12 -0700 (PDT)
Received: from holowork.tail3176d.ts.net (static-68-235-46-81.cust.tzulo.com.
 [68.235.46.81]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1166dcdfesm5434907eaf.13.2026.08.18.12.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:12:11 -0700 (PDT)
From: Fabio Piparo <holofermes@gmail.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
Date: Tue, 18 Aug 2026 15:12:00 -0400
Message-ID: <20260818191200.1300413-1-holofermes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818083143.37939-1-amit.barzilai22@gmail.com>
References: <20260817152500.703770-1-holofermes@gmail.com>
 <20260818083143.37939-1-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

Agreed on all points, thanks. I'll send a v2 with the set_window helper
and a reworded message when I'm
back in September.

Thanks,
Fabio
