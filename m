Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F5606A331
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmFDM3kh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9A710F7F4;
	Tue, 10 Nov 2026 16:04:39 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7705A10F803
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:04:32 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so1375412f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794326671; x=1794931471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4vUoA2NlXGcNUrmfCjgkgqsXq9gI1RBudmDyICGei0k=;
 b=lmFDM3khm2TAV6e2qWSa260QkXK8HvKJGSu6I3EDMrG2bVLemZZgXaHeMTzIvsoaRu
 IwCM4o8udFPBOUaH9BOsBGLjBXh+U6NyEAxzXr902SsU2bo7sVCXHUZK8v9DzKik4RPV
 8zBNnY6YJlkFeOkVTFSWRZA8ZZGDv8rRgJtPPcsEGZuWvpHQWOlMoIPO9FoFo8no3Wpz
 w3pbbatBCTL0KtXmXpeqPLQfaEpKK6PSYIWKOSHcL7eL4osUUUpfI4yQplVH0VjWW0F+
 sukXC8+uiWcjerVO0fi87ua+vJf7/aWC8uV2QmiE/P7REv5ClAA7YCdI22gnQ9eZ2ErG
 wWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794326671; x=1794931471;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4vUoA2NlXGcNUrmfCjgkgqsXq9gI1RBudmDyICGei0k=;
 b=M5UbxDdjDnwAxG7Amkx1NKIa18TMUINj4rTUL8LVbd2qKsMf7j3DB1Isn1RyiumEZD
 vzBq0T5+WZw1vToPQewA+EtXvg9yCtkBb3UuoWho5tVdoIbpTR2nHNZCa0K7q+5tc5in
 NgM0ClHlHEk/pDd/ICLUhIetj/tPFxde2KQgWrJh09xaNoVTrdKJHAaDNlO/PVeJgYH+
 CbYflbSmqqc6TFzQRjiivQM63GlGEf0ktjDbtJ4hQ+71PC2WVZ7m4WOVqiIMYk5imvKj
 maFTST3Rqm2dXEh7lI/NXk9lr4b075XYUFljKHUIAnYWC5mJKChCGOTYCSfgYkBGYzkF
 Hsnw==
X-Forwarded-Encrypted: i=1;
 AL+hErENe6Lx33Ze8LivHNJC/KFQpfLdN9n8wro0fwErIjuIZh+RRWBmifqpRhj+ribyWCMs5Jt6ODggWIs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8MtamcwDU2r2VvHW7eYkWxzSsSm/bNXa7F+451QmFXblUB7OTQ
 WUyIgz26gNsmv+TD/MtMh1S44DUR+ZCBRNnhXOArJuouzZBA7ie7QOPp
X-Gm-Gg: AYBFou2gnHxePdYY7WTOybfnwLx8kPxH8GO2oUgtp1EQZstRyfvRVVoGHhErHetci1/
 dFq9lh6TTh8rtuzcywpwidE5966OA2oQq4WHS901l5TRdU12E48oFlov/hlVPdMOoF7Wv7YywFS
 sNyAE7a88gKnr4lX63rKRCk+XYlCNTyuDvujL21QjSawjUBVADhx9LnS+h7NPucz8pBbtw63ilM
 yQ1hQ+BS5hDhNBQXuUy3NmekQ1Mw1tCYXV5jyLY8hMdOs7Rc03xX+rRok7DJp636NQ3KzLiGpvG
 wf1n8fojQ3zfw3KfKK5PRl+b4sPiKVW4fgi0g/5zf8aHUWeUTOdX5e6VIV1Kvevf2U+Qvs75fB6
 gv8bexMc998sX7QLpDH43ELP3xdpxwfYjnhC6qvG16QO1+nID7HqSqVkNWRZ7deDqCttYM2rmBH
 +ZOKBg6INvfF3KMr7YbvzvOXKsu++7qVJLcx4kXXtvwHW8YkaUH5fUdYAJXHddqvMuoVPdPFZS5
 y/emkGr8/9DRijGNzwvJ0ElQiJxy6SV1Ry2GLiKeTF30TxiSVL10e/BOiAmyEchoNVSzmK+dvMn
 R07HyMclF1T6UyHkW0Ex3unPuG4=
X-Received: by 2002:a05:6000:2584:b0:48e:4561:8a17 with SMTP id
 ffacd0b85a97d-4982ecf6404mr6123412f8f.16.1794326670681; 
 Tue, 10 Nov 2026 08:04:30 -0800 (PST)
Received: from localhost ([5.83.201.131]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835e20327sm6048689f8f.26.2026.11.10.08.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:04:30 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: make the read-only const array
 fw_err_code_msg static
Date: Tue, 10 Nov 2026 16:04:29 +0000
Message-ID: <20261110160429.892673-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Don't populate the read-only const array fw_err_code_msg on the stack
at run time, instead make it static

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d025b4183b29..91c863649972 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5427,7 +5427,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
  */
 static void amdgpu_ualink_remote_error(struct amdgpu_device *adev, u32 status)
 {
-	const char *fw_err_code_msg[] = {
+	static const char * const fw_err_code_msg[] = {
 		"Unknown FW error status",
 		"FIFO overflow",		/* error code 1 */
 		"Invalid RB command",
-- 
2.55.0

