Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DB606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=jY8WwHzs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2D910E02A;
	Fri, 20 Nov 2026 11:35:57 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4995710E02A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:35:50 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jWCvR41BbzKmy5;
 Fri, 20 Nov 2026 12:35:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1795174547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/0bdqs/qgeCys93mVvXwRWVh2IaXF81Np4A3J4rTk4=;
 b=jY8WwHzs6Q1nY/HVW87qifao149qyZcsSH60BpLATou3+sfLbyNEyOXikZnCx2VgJ8oxQE
 T780dOh/NgbjJVdMt8uRtlySjCECgbNBL9N6adsWtzLxbJVP/reQ+4iUmoioLt7JqI0DCr
 BiWozFaPVbXywQ5hebM4kX/vkXvz4shT5QT0cZZ/LTXe1NBo9Kwo2wb2dgRaLRDR+cEYgr
 iwR8A4Jp9bTmfRzZASrhnUy6PUv6Gry3jZWum3sbwqmussmlEIImW7qb4Czxa3GIz5XU5z
 11ebwmMFMmn01bvx+sAMEdxxnQ9opxps02Cbiz7kcHSWJG62tQTIVHjAN0GLhQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Fri, 20 Nov 2026 11:35:46 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, ville.syrjala@linux.intel.com,
 jfalempe@redhat.com, javierm@redhat.com
Message-ID: <1814225798.55871.1795174546719@app.mailbox.org>
In-Reply-To: <20261024165355.2782145-1-hugo@hsal.es>
References: <20261024165355.2782145-1-hugo@hsal.es>
Subject: Re: [PATCH v2 0/2] drm/client: Keep larger modes in
 connector->modes on fbdev hotplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.54.532
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jWCvR41BbzKmy5
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Gentle ping on this series. v2 still merges cleanly onto
drm-misc-next (c408466a4dfa)

Could it go in through drm-misc? Ville, on v1 you said the approach
should be fine. Would you give it an Acked-by or Reviewed-by?

Thanks,
Hugo
