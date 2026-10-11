Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81064CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987F310E540;
	Mon, 12 Oct 2026 07:32:25 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3CA10E021
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 14:52:21 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c02782159so640380f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791730340; x=1792335140; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZGMnoCiemVyU9rnhF6mteHDX55+EsD5DfdAIomQxYP4=;
 b=HHBzQ5DVNBupqEz6wzX4PplS7GjKXXO4IRBNL9wPEuWmx/undwvrjvFkFTqDoVgerg
 tQ/VCzhoP1hFoZFhMeguC/cLS92KHX1EYaO5QwaP8fy+KGTdjTxLL9HXTbGRKCzr8YHc
 pCc0KYUM9rtzHSH/4j/4JblUC5ijBAzD7DmTiOmE+EY4MAcFuDhOdI+bBpLiM6Ne7Skq
 6XEEZZ5PhfH0ZvD3z0lKeebEUXnI2OQM4/fkTA4cMXzeiQh05cFSRp06OgvRPmrQmAZF
 kOlk2DN1SNtSbuT2CTPhq3XoxLVvLmwcSJzN98Q9CHBGCoat/B7v6OZqjvwMpo4oPPhS
 RscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791730340; x=1792335140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZGMnoCiemVyU9rnhF6mteHDX55+EsD5DfdAIomQxYP4=;
 b=t8KmBdZOQ5Og18inW7a8735LvY1mRx0OJmX1XBIdcT5I6pyFPzqU5WssE8yknDscok
 h841P4Grxkvzecms+jcaPw7WAdSPDBeFHiO83h9z7NKWhE0GvzquPqLJHXw/6d4JVIAR
 2EG396iTFRKG2UV+O+Srh7fUcxcX9e+urpepSPWyt88hxQBh76i7Ax0Bb3VEfFEUY+Hd
 gXBRHSmYNgVqdKsy2g9RFsZKMkqWt34jAT85V5MkuCq37mJ3G4TiViVdXJobXFjr46M6
 fUFYEZPehGa8jsuecYF77D8NpJW3hLFBLDZvKrEZ0YYWxz9akp3fsXnJUztmXSH/SZGF
 YnAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmtZuIKNGe9Jj0xt6EGYxPH+N8jk1hd49ZCbGPn+lRIsdG+2rC7MQb2caWTBnPGsJbHkDmvQOVzQg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKS30GolKA1e2MYCl2fMDGX14MfVBfuSHqpvQ1d/X7Tc+PDr19M
 DDTkP2GdIn/kREYG64DhpywTN73lUQ8cXlvvAbycp4NGXz8z2RDe6z/m
X-Gm-Gg: AYBFou0qY29oXsswKgYJHvbSkD2t09pN5o03djE1tFVa6kSDEAdi4HATfpSlb6ooyt1
 Jvh+Fu0c8I5KZIXLFQjGvm/rdI+s+UY2hUOgsOEQrkhu8o7KP2GvdNII7fvJipxLTX7BLy55m54
 Y9R2KgbEOdm9YEz++9qZ0IG+X4KRZgrIN22MVJ7FiL+tpP70gxxfKjxNJAH1POvWyY541ItD3C1
 6lh+9Dfdk4zP3E5gty1jtxFevQ6DCowtsYSYdO5LjPlr5rHdH02YIo08/SZLaMcwaZy2tf5Z4pj
 4kbmDcXDHTcV2sPeDYT3Uo8UILwGOZ0VpEfL0S2UQ5ssWoDhQYB+1P2V8D7WlHsvlVeWPCF/Wsf
 TtOoAdo4rqFAwS1KlHgrrfqJAhs3bpKKIlzqn5Trk9HjwGd4lUbyV2XpV+5a5aTh66NQAE2p7gd
 nUCgtgT/WO+8vKlqw2jesfHtjZ2dYONRqwCuSig9pR8IEvB4KgKPFL3s/mA9JME03de54=
X-Received: by 2002:a05:6000:4915:b0:48d:b8a1:53c5 with SMTP id
 ffacd0b85a97d-48dbacf8813mr11389015f8f.56.1791730339937; 
 Sun, 11 Oct 2026 07:52:19 -0700 (PDT)
Received: from haider ([37.237.230.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acf232sm15265743f8f.47.2026.10.11.07.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 07:52:19 -0700 (PDT)
From: haider <soka11223344k@gmail.com>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: apopple@nvidia.com, ecourtney@nvidia.com, jhubbard@nvidia.com,
 aliceryhl@google.com, gary@garyguo.net, airlied@gmail.com, simona@ffwll.ch,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, haider <soka11223344k@gmail.com>
Subject: [PATCH] gpu: nova-core: gsp: zero-pad command queue elements
Date: Sun, 11 Oct 2026 17:51:05 +0300
Message-ID: <20261011145105.20829-1-soka11223344k@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

GSP-RM checksums a command queue element by XORing it in 64-bit words,
so for an element whose size is not a multiple of 8 it also reads up to
7 bytes past its end, and expects them to be zero: its _checkSum32()
"assumes that the data is padded out with zeros to the next 8-byte
alignment". NVIDIA's kernel driver zeroes these bytes before computing
the checksum, and nouveau builds each element in a zeroed buffer.

allocate_command() hands out the queue slots as they are, so these bytes
still hold whatever an earlier, longer element left there. Once the
queue has wrapped, a command of such a size can then fail GSP-RM's
checksum: GSP-RM never answers it, and soon stops answering at all.

Nova does not send enough commands for the queue to wrap yet, as it is
zeroed at probe, but this will break as soon as it does.

Clear each element and its padding before writing it.

Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
Assisted-by: LLM
Signed-off-by: haider <soka11223344k@gmail.com>
---

Notes:
    Found and tested on an out-of-tree nova branch that sends RM object
    allocations and controls through the command queue, so the queue wraps
    there. Once it had wrapped, the allocation of a subdevice failed the
    checksum, and GSP-RM stopped answering, logging Display NOCAT 0x28,
    assertions and Xid 45, within the first 5-10 cycles of creating and
    freeing a client, device and subdevice. With this patch, 288 such cycles
    ran clean (RTX 3070 / GA104, GSP firmware 570.144).
    
    On drm-rust-next as is the queue never wraps, so there it is only
    build-tested (W=1, CLIPPY=1), along with checkpatch and rustfmt.
    
    An LLM found the cause by comparing the command queue code with NVIDIA's
    open kernel modules and nouveau, and wrote the fix. I reviewed and
    tested it.

 drivers/gpu/nova-core/gsp/cmdq.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 1b2f346a23..ff323bb37c 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -384,6 +384,15 @@ fn allocate_command(&mut self, size: usize, timeout: Delta) -> Result<GspCommand
             (slice_1.as_flattened_mut(), slice_2.as_flattened_mut())
         };
 
+        // GSP-RM checksums an element in 64-bit words, reading up to 7 bytes past its end, and
+        // expects them to be zero (`_checkSum32` in NVIDIA's `message_queue_priv.h`). The ring
+        // still holds what earlier elements left there, so clear the element and its padding.
+        // Elements take whole pages, so the padding fits in the space that was waited for.
+        let padded = (size_of::<GspMsgElement>() + size).next_multiple_of(size_of::<u64>());
+        let first = padded.min(slice_1.len());
+        slice_1[..first].fill(0);
+        slice_2.get_mut(..padded - first).ok_or(EIO)?.fill(0);
+
         // Extract area for the `GspMsgElement`.
         let (header, slice_1) = GspMsgElement::from_bytes_mut_prefix(slice_1).ok_or(EIO)?;
 

base-commit: 5a1b7121a6c4db6c0239d3ac3fd1c2bb33a40025
-- 
2.55.0

