Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9EB606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=r1Pejf5R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A940411267A;
	Fri, 30 Oct 2026 07:58:00 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF0011268D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:57:52 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so166400f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793347071; x=1793951871;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UeMFe59C+6CGb+6QO+mNSCypQcnt2mUVBf/74RZRjcg=;
 b=r1Pejf5RTR67g98yPpQUrkH5Lh4XP01C77S4skRSTrHEgg5d1iPvWF+NKR+3G4UiBO
 9Pe0vFFiUH3qvqPFmq8bPrRpJ6f0g9MmdP2osGLJQ+lrKT9u4kuQx6VVKvAPWGKq30H0
 YOvRTIsS6/M6WLPy5tXMZNLaXhxSZ5eifCaTBUwi8YLpu1uGRDmwRFe68kplxZHptt4s
 2lZ4E4gnDbHUk+GGgJSYUhqRxeccY4Lvk/hlvJD2HRtMittCor6wyrQKouM7vA1yGSaB
 ogZEV3WP2L3k4trCAZTIlRuKlWE8fYW7FJ3hjFaRE2cDdNAB6cBgBgjN46lMUH0o+Hbz
 SBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793347071; x=1793951871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UeMFe59C+6CGb+6QO+mNSCypQcnt2mUVBf/74RZRjcg=;
 b=Z3YqJNGuB65RaMHhY4/RNSrdvcfSiWJb5oqaq+1gJybp42SdU2I8OpXpS8r596ueIp
 VNQyiaX86tRDrBCeeCrQqYlaIr4XgX5o9YQnU4csYfKwfsPzdZfwKmWzL2MPxDd1e52O
 icqlOk1/noPZGTL1bopKG+z1BoWgn2gFVpcRRl4d1xWhZxj4nvI+uAjWA494VCC0l6PW
 65t8eeEnEyjlJyMUGntbzJo7R9KOLwgNn421pcWSMJnwHb1zhbkd7Fzg6bJ8/P+/Bx1/
 +lDd2WONnPERHzs2VbQ/MjWmsQDisLWVD6eIUqn2tCGoSK8A5paaMpSqhDfzIppgvRmh
 3XBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/n7wKwbCxmQ9Tz2PSo38wgkzkHt9J/nzlpo5j6m6HrOY++Fz7saXUQ326D1IhiyaDKT2Jjgms/YE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKfK46Ui5e98xRdDvORoe2DPoAomM6hCZZUE6unqgLbZiECLbJM
 c2wduTsANqusKP/4bCcX+Rn7swMsTCzU9guqpxZPV5ePu+mqOeJAZX7ppw4kWX5ceg==
X-Gm-Gg: AYBFou1O9iRVv0e1lK1zSwW/4Rk0kb4KLaHntAtwgYVdBM0+c73x4NQTu897Sq/CCM8
 C7fNcoRL0xIsPNBre+mz9OGfUS3u9wg4akEXwPU1n/xNkIA2EkloDaY+PlEMXSDmh9FaXnUakJ9
 STVLttQJnFzCzPpXaIwJy6iUerkOvXCvzfPXTRXZeTi7GAOxwgtEilgxJ5tcR8qrABQ0DdoiAL+
 jyBhnYWAYtgZeAJ4w/RH8gJx78YpXPiWSZ7VFo98htA2RmREGhmGn09md6gAQ6BSmNdmL8wYUMm
 R4/1l4QBNaGcXRQOFpIQFLhiYBaKxxUonWAK/11okiydEWaZuKUL0xdvWEZSU4r2cOoqZRA29E6
 3q+VfblpTBLcaqbABqFUTtJwEculdfegyhmDy7C3oGMiIEUJZ+K1vRPLltp0LmIa5tzHfGgTVq/
 1iYhG7ipSXt9utobbEuyc3+Sd4GlVxeQNFRCp1bCk4K8Q7AiYOLp6QXE80xwTgxjen/0BpQiBdB
 dqUnsRazXhv5LeY+zXLKVxD4suLn+HkXBStuWtteilYyOM9uP34Tkwu/FnV3ND2X7Yqe2AFuP8p
 jE7rVL3vUX67EG9we531DuqX9UoQKBAsuapaXpr1HiN/sJ5UglSRvyrJXOxqtKitDL0crN+f0co
 /
X-Received: by 2002:a5d:588e:0:b0:48e:6bbb:c3f3 with SMTP id
 ffacd0b85a97d-48e6e2fd071mr3556678f8f.28.1793347070787; 
 Fri, 30 Oct 2026 00:57:50 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8bd8esm1676007f8f.42.2026.10.30.00.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:57:50 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS
 ROG Strix G513QY
Date: Fri, 30 Oct 2026 07:57:43 +0000
Message-ID: <20261030075743.356835-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
References: 
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026, Mario Limonciello wrote:
> Can you please get an acpidump and put it on a kernel bugzilla or drm
> bug?  This generally feels like an ACPI interpreter issue to me.

Done: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061

It has the errors and the tables from /sys/firmware/acpi/tables, minus my
local override SSDT.  I haven't got acpidump or iasl installed so it's the
raw files in a tarball rather than a real acpidump, I can redo it if you
want the proper format

On the interpreter question: _L05 is only Notify (\_SB.PCI0.GPP0.VGA,
0x81), and \_SB.PCI0.GPP0.VGA doesn't exist on this board, the dGPU is
under GPP0.SWUS.SWDS.VGA_.  I don't know what the interpreter is meant to
do with a Notify to a path that doesn't resolve, which is why I put the
question in the bug.  Rafael, if there's a better place for it I'll move it

Mike
