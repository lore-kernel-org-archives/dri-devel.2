Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F958606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ElK5enSQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBA810EBC8;
	Wed, 18 Nov 2026 08:23:23 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B3B10E70E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:11:55 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-33fb4680717so991366eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794960715; x=1795565515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K1OKgTmowWWdLoH03PEEFydtagLAJC60tXnR+xAM2B8=;
 b=ElK5enSQT/1xquk47cq0MHPzs0273d6TmLJgVI9NMYZFN8jXA425zjJOjVjIoQkRQg
 C1OikfZi9ji4d6w7iPLx+Df/lY7I6sdfRp6E6h+88AXCferavKy8Ch7r8VbUk8vQo2E0
 JVnv7VrjMFdo6H/0cPnaiZCsWcpkzpGAXACUGR+iMlWYFiYy5lnWyA6IkbEiIGf7h4Ok
 mgMpiA+Zso3hbpt24Dkar3Ewn0gC/OOMwtG88CogE4niKZmExV1fwLHPklRBLCwbsvqe
 q9NQCuTa9hU0BnZUcardped/Lj67PXK50V1uL9eUmgxvLOMdWmpdDoqpdy7MiuoWGA95
 sR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794960715; x=1795565515;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K1OKgTmowWWdLoH03PEEFydtagLAJC60tXnR+xAM2B8=;
 b=ai9/xcrWax8hwdrKMab/T7Xixhn+NXlHoJ9gPEdkYRkEOkwHEusp9gNOFGXmy8CPiP
 UhHC/bEW+mKERXaIY0hLizY107yc5aBVO7uEl3eIPWO6dSkNi413QAW79J8axPbQji6B
 wVzSbklKEmgmjnlmi+12JBfwcGRok4XN7G3kYfzc1mVNLoLaNk6Rbb033fWAX8Df9r8R
 Q6iTh/gMvBKwOEpDY16x5BRVKLwILCWXgvVveWEazSHgaOrx0fK6+0y+xHFcyUNvTd91
 exmQ9wGd4VeoE3RZ2LwGlY9VXlvmXYlYj55oKbAjy1aSb/FkgwfywpSNIsNZbzFaNosq
 fvZw==
X-Forwarded-Encrypted: i=1;
 AL+hErGkcGwMHxY/bMrFHPOanDd0MybX7cFqG8tLCF1YkVvh/U/FixVf9KQ2/yPHqL+VIWZd6YJErWHvfgQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+wW7Hw0pRGUP7xRConJLpyO8LGglC+JDB64hfx0p9xKdeZvCs8
 c4iEv7ebfoUhuY1jGzG1r7CAL4hlnRhMR1mFmOiSTtAdr1D55hWGt4B0
X-Gm-Gg: AZFdTZeYnPw1qZoah/tRDwP0T/hJaTpnaffixlg5Rkx49xVKwA9xrDstfby6zcPTC5G
 CSKOY4xfTluD/i8KFWpHpQ/URYRWdc6zh5ane8mE+rLXTQSnXjflCTpmG5eRyrvpSA9ilSi3o39
 /oJ+CpMVpcc0/3gcvhaNYaJD5ZGFS5ssmVWyr0raz9+qbm/vOWCnXIEg0GwbX6HrXPkOmS9bYvZ
 Bdazw9aANIXmIIkJuFvHh43o4BuHw7jkTiSp11tOUdLM1PoZOrf/U0+8ifl3InY9znaZNWQmXpJ
 oFkSshSdJv+YZTSZRQU+sPgwKeVJ5SlfzmmzNWpqNtf+J5Ps2g6qCsp331FcEQYgQRApAjHJSl3
 yWjervTOEsAI8ki0t794leAGVzxlw/vYWKQqU/SsE4TuLYhBFqPW4ujb48ODyb6kBylRNpkwufk
 wE0fTLNFfVR9JGZCuFRAU/iXfNpqFRC1rhyb0+LMVqVSkTzBnSNxc7A6k1hphrWpTNxwmMepo5n
 DDXQPDfmznCQOQzwISjYWtNldy2OVJp8TM/clzVS6aFRAB+yY63VEq15UMKd3MnG2pwwJbTLYgH
 EoukgVh5nSidUdZV+1qS3MYZcyNbmSJ10bbAwnplipDAdeAcfrcfFs1Kuz3AfssZ9e2TS3zk
X-Received: by 2002:a05:7300:ae1c:b0:372:eab:d700 with SMTP id
 5a478bee46e88-3827d71fd36mr1150388eec.1.1794960714122; 
 Tue, 17 Nov 2026 16:11:54 -0800 (PST)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72e52easm1344552eec.17.2026.11.17.16.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:11:53 -0800 (PST)
From: Henry Zhang <henryzhang62@gmail.com>
To: mripard@kernel.org,
	dave.stevenson@raspberrypi.com
Cc: mcanal@igalia.com, kernel-list@raspberrypi.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, henryzhang62@gmail.com
Subject: Re: [PATCH v4 3/5] drm/vc4: dsi: Rate-limit error interrupt messages
Date: Tue, 17 Nov 2026 16:11:15 -0800
Message-ID: <20261118001115.1299354-1-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028164539.3471833-4-henryzhang62@gmail.com>
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
 <20261028164539.3471833-4-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dave gave his Reviewed-by on v3 2/4, which I missed when sending v4;
the patch is unchanged from v3:

https://lore.kernel.org/r/CAPY8ntCBPwyZkM=F0_0EQOjMRqKO2Do_Cwum24ZGoWEofr7ETw@mail.gmail.com

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
