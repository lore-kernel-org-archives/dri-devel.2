Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C9606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZ5574nM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A5210ECDE;
	Mon, 23 Nov 2026 11:27:36 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41C310ECDE
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:27:28 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so1831698f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 03:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795433247; x=1796038047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z7l6Yjh1JSeT2JRed35IiGX95vMbKdZloECt/CtA1YI=;
 b=FZ5574nMb9w4HUj/LVKuQYcWQeDR4rqqoQPgMu+ussYz5D2gCPh9ObeXwuC+rtq/+2
 NuO2lbYA/CX7iOafXkYYuegh8o9oEc+Cc/R307LnijwOUMCWGyyIZWcxXlu80CGSgOrA
 t0HKaRNbBdqJZrobMPXkR3um4HoDUdnwJHP2lyfM1xgwB1FSo1gNytXHd3mYqrtFtQsA
 eoSg/yvHX3qfY072wpWQDWP3iOKicKLJQV8mODVz8tepux39SO6y/GeH044RCuqEbfFF
 /VyRIkcn2ohUGweQPjgaETnaOAgYdX9UtaoxqUU5YBmXfRrI1FdpA5hiF/x20Ss5eslV
 Dm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795433247; x=1796038047;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z7l6Yjh1JSeT2JRed35IiGX95vMbKdZloECt/CtA1YI=;
 b=BPgx+zc0d0oY4Vn0ZfMt6yqH3GH81SOUw6h3sqIQxgPHJylgraIPwxcG03c0otKV52
 qz1nNUar9EislYOpvf81Uv2CXzHQHgCg1qB4IxFTWKzYTQD2/9yOfg83c5lnBYO/ur55
 FOKs1WUwOVgaoEhQR602zDgSQsR8SrfcfAxwb+0vuZME+4/5Z+9SA+is2zrkCJ9EgCi2
 M4804lp1LqPRHMl9WCQPZ0lworMg8uIR6UQfvNRJRUtCDttpXmBEp9amPsY+iTHWNmBc
 +ei2+E2AJi7+ONQcP6e6ju5RzEuWRuVePTc45/vizaqTc0wQL7Re+yCjhZgiAG3pFJom
 gEPA==
X-Forwarded-Encrypted: i=1;
 AL+hErFFDSfn0OK6sGztIeC8lp9mXQq7IVDF14370vZGe0bbk/v+Eg4Z4QYyIaYGTNKZ1asE0DQHCN805zo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+hB/d+g3h5LEdnYkUUmXf/VQC3ZJXZim8RrgUDRi/F9dtUEL+z
 8q1IcLnDk4erMZ3ZtB4wL5Bd55MWo8qEiJ3G/VtZO3056GJzG5ATwgZ/
X-Gm-Gg: AZFdTZfXr3Ufzk+FbvM66jr26ty42NMaRuKmUSaEzmZUaGhDWQ6NL43/VkHNcSLI1Fm
 IGP/kpO6095vNbjbomaE6UQXIpWIt0PUK2M2o244Nq/S8vKtSywi55ImJg2GzfTSND0f6SQXLOl
 ExG4u4IyOfo28pFLUlxQN1qCffM6fiL/UBOcgrjvAyZwvWRzBdR+MwycgLM/wZaz2aW/WSBAyir
 Jru7ohl7MWPM3P+2++Qc0qd0GIEt+ccrRuIkuIZsIPwOBHqb7cAYIXPxvy4FCzVWHIIYpP4mr/6
 y/fQtaMgPED6ERX+ZWlos4jiTN5bxQkrURpGSyQIpF/YE6I9St1R9yrcihxG9vpjFWUIF1MK46f
 WjT6aUBoCRRiFeXPYJRSW4FT3P7gWEQzL0Lbg40HD5bgnFPX56++tNuhBB6RuNSdNM1G8PvhURG
 hofPK24WNTLOFdlHfR3zm3Ndeh5Cnf09XrEsFexMpzrrx6HmgwlXdIiwX8CBqRs3+6sXpdEVkU+
 VAFARj5itZKFcqlZMBLVEx5d8/kd2dmWjeHI9yljsktG4V6R4MP3ybPGBCHqmITQFHVd8gAluoQ
 /dTEgKKkqLR8Fh8NEUUZ3I8tAGadyNSIgBLmsLnCBxC9OYS1d7or8FO1x5ztUzFi3Bf8wQTwfp+
 Qt+I6MGTbqxOUqTmuZm/lLi5P
X-Received: by 2002:a05:600c:468c:b0:4bb:6d61:af7c with SMTP id
 5b1f17b1804b1-4bb88944bf5mr221650055e9.35.1795433246798; 
 Mon, 23 Nov 2026 03:27:26 -0800 (PST)
Received: from ?IPV6:240e:47e:509a:b87f:26b:b35a:8dbf:81dd?
 ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865b1sm336307275e9.5.2026.11.23.03.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 03:27:26 -0800 (PST)
Message-ID: <2f885fbf-1887-4740-a7ee-0189d74260a3@gmail.com>
Date: Mon, 23 Nov 2026 12:27:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Oarora Etimis <oaroraetimis@gmail.com>
Subject: Re: [PATCH v6 02/43] drm/vkms: Lock the config dump against
 concurrent configfs changes
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com,
 Jonathan Corbet <corbet@lwn.net>, Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-2-78ace90f4fc1@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261120-vkms-all-config-v6-2-78ace90f4fc1@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Louis,

 > The vkms_config debugfs dump iterates the configuration lists while
 > configfs can concurrently mutate or free them, which leads to a
 > use-after-free. Move the configuration lock into struct vkms_config and
 > run the dump under it.
 >
 > Fixes: 13fc9b9745cc ("drm/vkms: Add and remove VKMS instances via 
configfs")
 > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
 >
 > @@ -347,6 +349,14 @@ static int vkms_config_show(struct seq_file *m, 
void *data)
 >      struct vkms_config_crtc *crtc_cfg;
 >      struct vkms_config_encoder *encoder_cfg;
 >      struct vkms_config_connector *connector_cfg;
 > +    struct vkms_config *config = (struct vkms_config *)vkmsdev->config;
 > +
 > +    /*
 > +     * The configuration lists and fields are concurrently mutated by
 > +     * configfs (creation, removal, attribute stores); iterate under the
 > +     * configuration lock to keep the iteration coherent.
 > +     */
 > +    guard(mutex)(&config->lock);
 >
 > @@ -711,7 +709,7 @@ static ssize_t device_enabled_store(struct 
config_item *item, const char *page,
 >      if (kstrtobool(page, &enabled))
 >          return -EINVAL;
 >
 > -    scoped_guard(mutex, &dev->lock) {
 > +    scoped_guard(mutex, &dev->config->lock) {
 >          if (!dev->enabled && enabled) {
 >              if (!vkms_config_is_valid(dev->config))
 >                  return -EINVAL;

Now that the dump takes the same lock, holding it across
vkms_create()/vkms_destroy() closes a cycle. vkms_destroy() calls
drm_dev_unregister(), which removes the vkms_config debugfs file and
waits for its readers to drain, while a reader in vkms_config_show() is
waiting for that same lock:

     echo 0 > enabled : holds config->lock, waits for the debugfs readers
     cat vkms_config  : holds a debugfs read, waits for config->lock

Also, vkms_connector_detect() reads cfg->status without taking
config->lock, while connector_status_store() writes it under the lock
and still allows the write after the device is enabled. The kref in
detect only keeps the object alive, so these two are a data race on the
same field.

By the way, Fixes: 13fc9b9745cc looks wrong -- the device cannot be
enabled at that commit, 64229b846a7e looks like the first reachable
point.

Thanks,
Oarora Etimis

