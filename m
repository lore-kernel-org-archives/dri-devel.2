Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9FAF4613D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F1910E423;
	Mon, 23 Mar 2026 16:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="RAwcgE6X";
	dkim-atps=neutral
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5E910E423
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:01:19 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-67bb19ac35aso177417eaf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1774281678; x=1774886478;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmhohN6RlSLZwmw7GnhmaqXlOUkxWsMUSbvXDFRlGSI=;
 b=RAwcgE6XA7azgjZb/yEEmyldXysDIJqs4ijFBv4DcjOKSUFlLL07ijMYiaFxAW0Lvn
 otFo2XKWHY6pLiRUzkzUuLjVcGcGOpVLNKqYw/TtLuQL6iJLrSZt/2aTJu2Ylt4KuxGI
 6zjXESLdORCXYYvwadJf3CdEPJ2tYSj3xJZz7theg+LXrqDXdhh5/bvaPnnGNJ/HeGb2
 67gj9dKM314VnwvRkwOmabglW5ts4LmT72dnyufEDiuPnyxlrxkRqe4eoktZVJxo0rx9
 MUCNr3ivUEZhsfFzDicUVJvBG4qmkZVNV1QgL/QZQ+9lwDWgu5sPzTG3FJDCeI5vytYb
 qOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281678; x=1774886478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rmhohN6RlSLZwmw7GnhmaqXlOUkxWsMUSbvXDFRlGSI=;
 b=FOYuLNhHEr3rYQ2OYQm9alqCJQwbH1F5v5VhBIeRSJ1QJJu77/iZOAXdHEuMlqWqPC
 4LGVBtmzZL7+Q1NjJvxMW05e4DdWsiLvosVgJpO5I5JZxwUOu9DJ6FWgiRlD8bJrco5R
 l4J0Y+eZFzyULGzLNbovoGql/0mFkrnLQMjximyYU0JfU4fMVPIOP2khziXqfv5U7h61
 uwoY14XAtrXtMImrLT+nxJuGWVVzjlj2MQ0rTRhHMeJ9KCJ2mVZ0Iwwwqcn5nN6HQRTM
 8As39gGhTy3DpMHDmiJHvchHjq1bjcu5O+kUlCZAHekk/5u9d2AFxyCXV4N/BUMoab+b
 8LlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1eeoD2x0iGoXuYwfHdE1Yoz5tjD1EmrYu+9XsGNMpWc0c/m6aJURNLEpupm3i5R3OS8HZuLL2J9g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6jRT5Orc7XMuH4o906D3CfuYiwDLXb4EudXmAj69LGGD0gX2z
 y4qSvVeFTU0Qda00TkcWMpOirSn3eHsJzu9hdwbIjQNnNovHf40h3sFjzblp/5ThnfE=
X-Gm-Gg: ATEYQzy8XIGZZPw0DKbEXnYXjT5FUEubrWGPwIJxGi7qWy4NpBTIBTP76AEfzO8HjjL
 Ip8ClZZpCduzL1cd7CwKR+GByk/6hYhDRSxSODW4lUnixJJ8xHr5HYLMg1cRqslaDUM6tnccHs7
 ECgUuq5bTZCF9xSmWP2mllOPGDlzFi+kaS8O6qtvlgrNL7JcxKoQbgiGj0gXZtXDsGYIp6+673H
 gpehzp9b+U6godSj3zjIOAoiDR2b4YAIYmxf5KVqgT+9kbvXioVzc7lXy7GiaXAUwed+J0XcyWQ
 sXDNkJJCI00BOOeKC4/d8KHTpl/K0rY+yie3aZzp9biOph7KDf31fTEtR6tEHNpLo/sJlm9mrdD
 BZVp+RLmkwt2xPjvlmkbjLyPvZERU24PrFIkHPJceghSN8BUuhxvD8mymKqO3zpEWWeD8Yx6Ja6
 llBuWaIM4IeNvVURTyLTdRr2ywlB5eYbhfUfbEhduCCFgOrje8HAXyblTXV0ynjE7OtNMy5hhav
 Zxr
X-Received: by 2002:a05:6820:179b:b0:67d:6597:4d1f with SMTP id
 006d021491bc7-67d65974f79mr5464593eaf.58.1774281678262; 
 Mon, 23 Mar 2026 09:01:18 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net.
 [73.143.21.186]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:01:17 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 08/19] dma-buf: Use trace_call__##name() at guarded
 tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:27 -0400
Message-ID: <20260323160052.17528-9-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 35afcfcac5910..232e92196da43 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -535,7 +535,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 
 	if (trace_dma_fence_wait_start_enabled()) {
 		rcu_read_lock();
-		trace_dma_fence_wait_start(fence);
+		trace_call__dma_fence_wait_start(fence);
 		rcu_read_unlock();
 	}
 	if (fence->ops->wait)
@@ -544,7 +544,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 		ret = dma_fence_default_wait(fence, intr, timeout);
 	if (trace_dma_fence_wait_end_enabled()) {
 		rcu_read_lock();
-		trace_dma_fence_wait_end(fence);
+		trace_call__dma_fence_wait_end(fence);
 		rcu_read_unlock();
 	}
 	return ret;
-- 
2.53.0

