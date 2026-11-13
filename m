Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1B606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B466C10E301;
	Fri, 13 Nov 2026 20:02:20 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D263410E301
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:02:19 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-8b335eeb340so13461427b3.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794600139; x=1795204939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ftLGNIEMed5JUTDYLuZhEChOGJfoU58LD9PZZL0hGOE=;
 b=p+SJyBiVi0isZ6WRZL52ZqRX3fROKLLPkI0r6DSPNT5FGG5MlAYk/tLOkpCzoA3z4p
 kDUEAtFo2TgycWe4VUtYSDyTJ/Q7lZKmZzot5P31OmuwHvKJy6eFQ1RDQJ70EGuZyhhw
 O7ER3AX6LdKMHnPWkaFGqwDL/MeOKUu7XZJDe3JsWoITS+7k2BCiW5lBHMzX8KBO1Kky
 szyKDNj84LlGAniFm0Qtp0tSM8OMfbptRqxpNTp8kVzTWOxZqKQQsGZhYrkCEG0OHopd
 oiJrIxYyeBuPZFHOJUtER1lpd2uomLChpw9I6fLHgVYKoGyyJW3phmI8aF5GdZ/pvZs7
 h0sQ==
X-Gm-Message-State: APuU4Z8zFksyyINlRhk34yyR3q9aVd9S8U+C4R7/gkB3QplMDF2S3uFB
 vdxWDJAcqaTkGf0Qh9S0sQJT/dCTc7Kf5eMXbrlaYFZfSGKSdqrtQCmWj64TLttfaps=
X-Gm-Gg: AYBFou0aTwZDZmq6/D7AuFuE36EANknRTaH2LU3vGlAnD1x9Ww0EYVjxTzfGLU6anAz
 lAM4ZnZ73w5Gd3Y3j4RGDbrhc3M4xacE4Hfi/VcPVYVwtEfsDvuO7aYEn5fZ3LpcNjDm7TrUZUi
 hJrbdTFKSdUNOq2VBM7/SXZiKAtPPWUqqwRKmCYvUo5YNUSCUL+dif3Wh3zcQxAH9rNzfCkPI3k
 IY+8bo1Nl2nQ//vF5EEAkLHtT2Odg5sxFb4yEppHN2GtMv++QWwvKZNgjM7g06atvrODpcx8IyM
 GdDFPGsZpm5ZZ8mZg5KhSPC/C4reCG36pzUqZCLo9E1sr/cxg47o+YnliYtaIiuJiuee+3NgPS+
 RqMf4Qo+sg4QRP7dSI+m886AVE6v3DQWgcbymglnW1Oz9L6IZYDJO1xWPjWrOntAPnSGRiKJuZS
 vi+HPLoh4a97UO05qUYMQGNC1YjLwU4ibF2IDQ62B5By49NXOJs+JLCoeWtVz0sxK0e8RvaerCz
 7bstEp6R+HJiwYa05jUcOgfD58uSGoEuQmOmYK0FxfApc9uwQX2z23M4nwNbQq9GojiH15ifkZ1
 9Rff5G0pF/pCjLm+a+k/85VEHj0GXGSY+eZW+q6D9qeKrgqzBEWmhoyDKQCGdBHw7cAedG+CQt8
 fm7uy2bse/sSe8WIbDbwr9Il1x0+r9Fw=
X-Received: by 2002:a05:690c:a:b0:8b1:70be:d4d0 with SMTP id
 00721157ae682-8b4aa25cd42mr23621487b3.48.1794600138833; 
 Fri, 13 Nov 2026 12:02:18 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa9da90bsm28205227b3.37.2026.11.13.12.02.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 12:02:18 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 frank.binns@imgtec.com, imagination@lists.freedesktop.org,
 operatingsystemsdepression@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/13] drm/powervr_sgx: Add a DRM driver for PowerVR
 SGX5xx GPUs
Date: Fri, 13 Nov 2026 15:02:16 -0500
Message-ID: <20261113200216.82392-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Mesa side is now up as a draft merge request, for review alongside
this series:

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/46286

Joseph
