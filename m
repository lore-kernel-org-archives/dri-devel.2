Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB7606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UOF4tQrY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A36C10F474;
	Mon, 16 Nov 2026 21:40:13 +0000 (UTC)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3F410F46D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:39:59 +0000 (UTC)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso174240a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865199; x=1795469999;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=KXctz2CHgX9skj9+1rLSYCf1QZZrfwnuzjJ4so/DDKQUwZsiqis0CSkyhfAEeSPEtQ
 cuYFXWqgjUooKfpIQQKPJw1UuOfwjiwJo2JBTbPN2KkkVVC7NykUe2FmYYekfGQKtUG7
 +crICc9wW2iL4jaCFSABmf0Fh1UG4usOP/Up1cuJp6tHMD1uRkA8TUgQvEV08Gm8Pak5
 UHyXmMAuDpKPD3fX3p3TE+WRJj/K1X0kc6Zv4gKVoc7ADZnbiJgagqJoW/dJ44nhIE35
 s8B3ps/5utp/Thn1ue+kIMoGz7De5Gb+F5vkHsrswvWQor9RPUdswYzU5KXvihvlX0VV
 ddKA==
X-Gm-Message-State: APuU4Z8mSgfCf5jRMu+dvEtM0Q8G3HKJzq7FbHXS3KviT2BOfyPT4AJF
 7xfEaEKUduMwhgsjWBHex5RcbBX67dDJie+F/J5JXhW2MHirzvpA0ZVh0ENrjXZR9NCIX0Ywks2
 37u50XmhoYXeaeGL9ZuzIK8y2i67leaB6KlZBuTTKlMnKcddCHvfw3SRDTcDZj2zSL8XCBI1bdZ
 wdg7W4QxX3QRqOeLswXk5gpqrxjOQsYPqr+1kUjyaLwLIUjgPJBLVNByy3xaj59IwHyrShNpZ98
 01FhP9t/CED+2biBnD6
X-Gm-Gg: AZFdTZdgDiwq1rm1fDXP+pBEDfXLTkhu1fDFn5v4ZdgtQuRzOKIC+IyfzTi78A0X4TW
 E5HcQz8tLzVCIMrPJ1yT5O0VjFlN/6lu67/kenUNpFlyToDaorfSnv3+oJcciqzzITSV5AKDswr
 2JRkuRV4M3MUlRqY5dxBhzEBnaMhQyAmQHIy9cW5aHz1kG1Nlc8VOlmpYpzzdEuH4UwIUsooALo
 C1ilYGOlHEAdaNHAppYpFWFoGYNkOaa1vKJ9CoLtVOSv4O9MY8f4RHT3fcS7viwLBG6zHeZ5kM8
 wh/3oPVPxcZMqzLXovcTbkOqsGSgyAKwlGdBrQB9BCGNxUDcU833DN3aZijC/ckdIberSBcnWFO
 BAvUHsGk8KM22/chGjY52PhGrx5ymOIPUdmyz0dSXhXGuNcb4KjbfWutq39ri/gK9pe4Uzcx+Vr
 4+ZzMvX2s5gx9/DrlQBj3kmcQZZmsBYg8S+hg=
X-Received: by 2002:a17:90b:4fc2:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3b3abe61f72mr397211a91.38.1794865198659; 
 Mon, 16 Nov 2026 13:39:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3ab9f198fsm475549a91.0.2026.11.16.13.39.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:39:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-375bac6bd21so225514eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794865197; x=1795469997;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=UOF4tQrYsbpZ2fTOmNMWRPv8S2f77IA27XcWLXMt76kWGZUr2ruNy5tGldrrO713IM
 XdMCL4dW/sPJbth3PJOAxyCNepwrZnPUroo6yOy+OPqgjbsatbEmbwVcxi0OhQRN0ZGE
 u6oTqT9fvnp/atwkzEUkYO9l7oI/3vQoV0gHI=
X-Received: by 2002:a05:7300:7b1e:b0:36c:a3ae:936e with SMTP id
 5a478bee46e88-3810e418910mr743300eec.5.1794865196978; 
 Mon, 16 Nov 2026 13:39:56 -0800 (PST)
X-Received: by 2002:a05:7300:7b1e:b0:36c:a3ae:936e with SMTP id
 5a478bee46e88-3810e418910mr743271eec.5.1794865196316; 
 Mon, 16 Nov 2026 13:39:56 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955ffcbc9sm52707892eec.18.2026.11.16.13.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:39:54 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 maaz.mombasawala@broadcom.com
Subject: Re: [PATCH] drm/vmwgfx: Check whether CRTC is active when updating
 planes
Date: Mon, 16 Nov 2026 16:39:52 -0500
Message-ID: <179485275607.3430538.17535791320298247054@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522195303.797091-1-ian.forbes@broadcom.com>
References: <20260522195303.797091-1-ian.forbes@broadcom.com>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you. Applied to drm-misc-fixes.

z
