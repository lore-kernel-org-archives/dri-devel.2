Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591F606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KPS8kooM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49FC112C75;
	Fri, 27 Nov 2026 17:59:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B4E112CB3;
 Fri, 27 Nov 2026 17:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802367; x=1827338367;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=6QorhscBLaL1Q9416qZMatrzWAOK/ub/xGuVXQ0qvMk=;
 b=KPS8kooMKZkAKi1NBD1QiPehD0pwymoImz1WlZtQZS0AEOl+XeMIIqcK
 3W1pGvFwhlPHpKvW3j8jtQzTRj5weZT6XorlXZLaPO0XOmysu5NvYenfN
 Vys38uQ54bF4A48PuttIR80+d9nX6I97C7upiP74X0nzHApHj31uWMkfJ
 3Jm2CC9/snrSmIP1zcvpQdKO1Vlwi7bgaUyu4cMNp/5OeY3dXfr7sjVpq
 9vKtLgxSkruoLA4jTWJTXKfGclOUQd8eC21FvKPYPWL70/Dwi1CdEHAVs
 T90zQNDzGeow84NLOm3zqnaNQhkoplJ3cPNCvigP2de+JM2O3/mvTFyjQ Q==;
X-CSE-ConnectionGUID: Cj6a1IIrTHGoiWij3WwWMg==
X-CSE-MsgGUID: T4XWMJfGR2SsRo2rAYhyEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4717096"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4717096"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:26 -0800
X-CSE-ConnectionGUID: cLOLiXl6T9udL87yhHhifQ==
X-CSE-MsgGUID: FmkKLvDBTzuMmKToKYOtpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12228731"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:26 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 09:59:25 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaOjfSSGfAD68zS2XnuU/KdFBElHoPGYGmCvoU0bls4f0fqgkJC1hAt7cWLQ21tWSikpScriWqR70EzFtPLAQOfaFNajbEnDl0Gwt8dSRk45gBi/ob5R60R9qTv1QtVhk27+ES3lXn1sm/uB79TTXhO2lCZeFnbJ1C3pQZqBSrGmshswpKvc12y+aNxLmzqTILGl86zh/EMCWOAAVgclbBmQf6KfwEZNLZL4PVdNIBOksFTEXSwuj1CUxni0y0g7+J/hYwqOts7f/HM2YEL5w4E2nEplhxonBEqxp1rAHzZsG6Dn/KjPgr2VX0cbXRRXZogkG3KQlD7rYKgsHQuSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79P1nZ1kIotqeKfAHy64jZZTp1ha5VcbzLigbg35+EA=;
 b=os6UfJ56QZ1IKE7I+yXzLY2bHslS+j2sfwxi1cblQBZvfmgAy58hl6PS73IJ/7EogYjUkd8jQHDbM1BEW88j3LQLdnBCIxggyyIWDzLzVnoG1gLQlFoQuS5dXizg+etMZ06ntYh50wIrUsKsp8l8FlokkkIkUY8f7gk6R6uJUuHbWCn4aZsBHBQ1N0axvtHI7NY9v+HXtDwSGxsviDUjH6SLDRApNOP3jzznk9spyaDcNsgr5ZsmqC5Z1sFdCxd8MV/BGYjp/fHoseNQJa1jyyBv+kvEVx3tTEiSoaZf+dqzGRZ0W7qeB4aHLyKdRLTPcDCi/55ySW3qgJomOWypNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 17:59:20 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 17:59:19 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH i-g-t 1/9] lib/igt_drm_ras_nl: Add node and error counter
 listing
Date: Fri, 27 Nov 2026 12:59:12 -0500
Message-ID: <20261127175914.784751-10-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::32) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0da659-d100-4fef-4720-08df4cb0290e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261022075727099003|261021121427099003|10067099003|261009223027099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: MyAfBavoQRo+vdUuvRptuWKxTp8cuhrE9rDzuVS7U7cbyzIpMwdOq3SFKzRQMiN6IqJ6bfdf/cVbGP/MN9AXrzkunrm3/AgSyTdyNAxrcjQL0PzrQFljPJvX7vCAVFmxN/AZvffkGKK9JZEX7yo33N0eaUwdPD+JQVjpGd8NVKSUwqh9BbvvXv93315MEsymDim+XfQwLeut3jLk7sx57WM5EdxxaUx3WnTYGc5QO0EamomkHh3f5r4isMM4bZgKHKuRbeK12HY85G9ZHlKn0knUXcDXsO0fU6RYW7fc11U597GQCY4ukWvfQokUw3FnAcsb7aAkpURc75zGJeQNWTHoBFf4HrRwM1dVo55FMUxDljezWXe29HgYfWaLbk6zrNIvZMlEDrFuirdVIscZeaa+8O/jsy3xXruNKTbuojeyxTs9vVjbUEkWDWWIXG6z/Jj0MVZTJl+nhjq6IIMJSoHgwfoE+nNzHF/BIgDu/VCM7KHQVQ+z5FWedwjsa70Jur4RVqawE7RBIM3q07gElBC+c/kbVThciFVZMoJOFDfoXvvF+jWrDTr8R1SdImtUbMHr9KctXOGgVmPrrMQ99pV6U9r2x6rDo4p7XH3EJhuBHbtEokHvW3bfqd928JczyJquWGrrSOFhT4NaLACapFjJaPrmF2pF4HI61/jpnDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(10067099003)(261009223027099003)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GiMLml0hqXYL9qieAO7c264zPMtiEifWuApgjWVpfggWa06bg2z4I/gDO4f/?=
 =?us-ascii?Q?Cv2dh/uObKRrj4pNKeaPTh0xnVw+aEZhrYJNterTapppRrRpW2uztWkqESNx?=
 =?us-ascii?Q?Rnst3pe9rnnGDE5Nmyrk+PydODgUkx1eAkXj/iQN0PhYyKbNuX9iJPUYkjZf?=
 =?us-ascii?Q?5gg7ANoSSeJ5Y4Pffn9ulol/ZcLPOEvSykKmsRpcNIW8mTeJ/QgqWFIqt6+g?=
 =?us-ascii?Q?H9DngTjjyJ8BrYcdby2KDK7LGUPKpaVyNf5Npr7qJFc9h3f6uOVUvW79megx?=
 =?us-ascii?Q?SPxOH7MpCuzedcnzCaRoEDbbl79y3S9tSQBfitkROp/+jJZNkqRe++IMWrVN?=
 =?us-ascii?Q?e99p58f8HgtGYk2rQn67IVKyYaOuW0ONgp8S3G7jRhJ3g9QNhcf92w+bClnf?=
 =?us-ascii?Q?CnndzwRb1BIlAcF0QUPyFnO46kSu7844p/YsqVgNThFfQWZVqY67iDadR5ue?=
 =?us-ascii?Q?3v26J06DGQuEiaIJvbYI0i2uFuT6qb1gGCGvzOH5+9nLIggElI85zTtHwfTk?=
 =?us-ascii?Q?0XoXTArYkbpKMAbjsIPwLAziCw8wpTHi0vrD6ruZtY+G9wW2zTshBIfJsiCY?=
 =?us-ascii?Q?zh9b2BhL1Uhbc+RbQozRTjv/aYmqKEAoqlG7g1rWyIzzTxdGtmtD9mGZHyCp?=
 =?us-ascii?Q?5/hLZ6eJKEOJ/vS/CEyuYdJR+cnTGzKl9qUhj+4JKq3wsoZIk9mTsOKFQG2L?=
 =?us-ascii?Q?9bOhcpaU80rANfI7L6DfB0xIu7v8v1hWKVsPxuzr9etAjoulr2lWAwSJyGQ8?=
 =?us-ascii?Q?TR3m6hECiv9nwg88ig5QwIlXsh4CTHBoj8Ibhr6tLx/16TK+IxV7TLwvqvI5?=
 =?us-ascii?Q?EWzpbVR4blPYN0/G9rVHwDOAAI1UpjUUOXwWA6LVbpRgZBZVQ0MEqcYO2w+a?=
 =?us-ascii?Q?EFeIScN07tSO32KCqySsysAs+ZSdypZ4bU+n7FMXktDd/Peo7s/s2gi7Xhts?=
 =?us-ascii?Q?9PXqa0/ojKwlf86Nxb7iNJ/MaAiHLc5o2PLWgmBK/0bJAmQnH/NQuWNId9O5?=
 =?us-ascii?Q?FySV2QyiWnpsrUNYOitHjpkRDskDRMHOIxFA0m2gezhSDL8P+e01rtSHwWv8?=
 =?us-ascii?Q?KMVY3IMVwWGajnKWGvT8IyB6p519n39BQJJbPAJQGXCfPW5ElrlwhsfgcfAe?=
 =?us-ascii?Q?JP09plGyQ0DU0xcY6PO6MNGa6akpTXekPqdToV1qeSEiTpHGS/nLsKYhF+zi?=
 =?us-ascii?Q?sVzOrXkAwmXRpPWQvhgiBTu44MgS/hRosSaTm46ZXEGuW9eZcNkd3olXBpX7?=
 =?us-ascii?Q?EWli2XssThBPrbkPp0xN3wg8Wl6mrRcgp7DVVtRhAYH1esJQlcHkg6QHFGeC?=
 =?us-ascii?Q?WJ0xxnPcxUlkZpWkFuBGizyUha7qJ6E4apJfFayBvGx2DWMzNkK/YQFtSfqJ?=
 =?us-ascii?Q?Wudkvo7n+j1F9yASc5Tbme0v24gjZeCBBbIzDV4u94dPpO196/e8MXd/8OU5?=
 =?us-ascii?Q?x5XW7fDs4M73kwJc9JQJnS89YaMUUScK0a+9Gme43WXuA4Uhfpkt3mn0fZc2?=
 =?us-ascii?Q?NK0z09+a9mzeNDNjCRGppRfweqiSINvF2/usombxfSsdaEVIy12Gzi4+wXl7?=
 =?us-ascii?Q?/06P5743NctTOqcTzg7GSWXlOivAGf4SOYcV2c+0aG6WVidckyg7wwpYf1Y7?=
 =?us-ascii?Q?Xw/ISq73BiK95phHa+HMQmsqoG1WoWkLyBxvg809xziDcAFvzeiYPIp1uDjp?=
 =?us-ascii?Q?RRBkAdoXl6qh6jgjEUAm4amHtqeYj4eQJq44qLz5Nja/GlQsQJQvQCQ6MRgu?=
 =?us-ascii?Q?3LyEDN589A=3D=3D?=
X-Exchange-RoutingPolicyChecked: hNXr2V67uIvwKcWUEwYzqO2vuGn92Czm0eqHYAJpfGUGrpVZ0cnRFN1zPzKSchWYh4fnlSqU8nfaZIXJVxsLkvs0crZDfq+VyktXwov2ro0ZquDMGxyduximVtpEBBxBmF0qwiCGEH6uAvFGOLec5ZyGlVHbS0S494tZ0TV2FSlk3bCBT26k/ysE71fT52OYSRJpJhaYKgmnFmwQXB+rLbKbrcp3d++T8q+6OiLIAv1bCVa318u+Ea4Mumrg3VFghZsA/Q3C6JYUZlJDiuhQ+o1uI8rC/y5bjpRNIbGx2dD6ltTNIZ/pq20w++TUKABZU4nu50rAqhF2eegTWjbUUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0da659-d100-4fef-4720-08df4cb0290e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:59:19.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCPdKfpqSl3MREmDyHlzjHXWBx90iGAZIYH9joLPQN+AZXyfi+1ONOq/yTypoU7AHuNcRA5a+cZ43y0MNo4YFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add igt_drm_ras_nl_list_nodes() and igt_drm_ras_nl_list_error_counters()
on top of a common request helper that reads until the reply, the dump
end or the ACK, and records whether the kernel flagged the dump as
interrupted.

Enable message peeking so dump messages larger than a page are not
truncated.

Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 lib/igt_drm_ras_nl.c | 172 +++++++++++++++++++++++++++++++++++++++++++
 lib/igt_drm_ras_nl.h |  39 ++++++++++
 2 files changed, 211 insertions(+)

diff --git a/lib/igt_drm_ras_nl.c b/lib/igt_drm_ras_nl.c
index f7ee3e373..282648f55 100644
--- a/lib/igt_drm_ras_nl.c
+++ b/lib/igt_drm_ras_nl.c
@@ -398,6 +398,7 @@ static void reset_drm_ras_nl_context(struct igt_drm_ras_nl_context *ctx)
 	ctx->event_received = false;
 	ctx->family_id = -1;
 	ctx->subscribed_grp_id = -1;
+	ctx->dump_interrupted = false;
 }
 
 void igt_drm_ras_nl_cleanup(struct igt_drm_ras_nl_context *ctx)
@@ -424,6 +425,8 @@ int igt_drm_ras_nl_init(struct igt_drm_ras_nl_context *ctx)
 	if (!ctx->sock)
 		return -ENOMEM;
 
+	nl_socket_enable_msg_peek(ctx->sock);
+
 	if (genl_connect(ctx->sock) < 0) {
 		igt_warn("Failed to connect to Generic Netlink\n");
 		igt_drm_ras_nl_cleanup(ctx);
@@ -657,3 +660,172 @@ int igt_drm_ras_nl_wait_for_error_report_event(struct igt_drm_ras_nl_context *ct
 
 	return 0;
 }
+
+struct request_state {
+	struct igt_drm_ras_nl_context *ctx;
+	bool done;
+	int error;
+};
+
+static int request_done_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct request_state *st = arg;
+
+	/* A dump that fails reports its errno in the NLMSG_DONE payload */
+	if (nlh->nlmsg_type == NLMSG_DONE && nlmsg_datalen(nlh) >= sizeof(int))
+		st->error = *(int *)nlmsg_data(nlh);
+	st->done = true;
+
+	return NL_STOP;
+}
+
+static int request_error_cb(struct sockaddr_nl *nla, struct nlmsgerr *err, void *arg)
+{
+	struct request_state *st = arg;
+
+	st->error = err->error;
+	st->done = true;
+
+	return NL_STOP;
+}
+
+static int request_dump_intr_cb(struct nl_msg *msg, void *arg)
+{
+	struct request_state *st = arg;
+
+	st->ctx->dump_interrupted = true;
+
+	return NL_OK;
+}
+
+/* Send @cmd and feed each reply to @parse until the reply, dump or ACK completes */
+static int request(struct igt_drm_ras_nl_context *ctx, uint8_t cmd, int flags,
+		   int node_attr, uint32_t node_id, nl_recvmsg_msg_cb_t parse, void *arg)
+{
+	struct request_state st = { .ctx = ctx };
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret;
+
+	if (!ctx || !ctx->sock || ctx->family_id < 0)
+		return -EINVAL;
+
+	msg = nlmsg_alloc();
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!msg || !cb ||
+	    !genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, ctx->family_id, 0,
+			 flags | NLM_F_ACK, cmd, DRM_RAS_FAMILY_VERSION) ||
+	    (node_attr && nla_put_u32(msg, node_attr, node_id))) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, parse, arg);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, request_done_cb, &st);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, request_done_cb, &st);
+	nl_cb_set(cb, NL_CB_DUMP_INTR, NL_CB_CUSTOM, request_dump_intr_cb, &st);
+	nl_cb_err(cb, NL_CB_CUSTOM, request_error_cb, &st);
+
+	ctx->dump_interrupted = false;
+
+	ret = nl_send_auto(ctx->sock, msg);
+	while (ret >= 0 && !st.done)
+		ret = nl_recvmsgs(ctx->sock, cb);
+
+	ret = st.error ?: (ret < 0 ? normalize_nl_error(ret) : 0);
+out:
+	nlmsg_free(msg);
+	nl_cb_put(cb);
+	return ret;
+}
+
+struct node_list {
+	igt_drm_ras_node_fn fn;
+	void *data;
+};
+
+static int node_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *tb[DRM_RAS_A_NODE_ATTRS_MAX + 1];
+	struct igt_drm_ras_node node = {};
+	struct node_list *list = arg;
+
+	if (genlmsg_parse(nlmsg_hdr(msg), 0, tb, DRM_RAS_A_NODE_ATTRS_MAX, NULL) ||
+	    !tb[DRM_RAS_A_NODE_ATTRS_NODE_ID] || !tb[DRM_RAS_A_NODE_ATTRS_NODE_TYPE])
+		return NL_SKIP;
+
+	node.id = nla_get_u32(tb[DRM_RAS_A_NODE_ATTRS_NODE_ID]);
+	node.type = nla_get_u32(tb[DRM_RAS_A_NODE_ATTRS_NODE_TYPE]);
+	if (tb[DRM_RAS_A_NODE_ATTRS_DEVICE_NAME])
+		nla_strlcpy(node.device_name, tb[DRM_RAS_A_NODE_ATTRS_DEVICE_NAME],
+			    sizeof(node.device_name));
+	if (tb[DRM_RAS_A_NODE_ATTRS_NODE_NAME])
+		nla_strlcpy(node.node_name, tb[DRM_RAS_A_NODE_ATTRS_NODE_NAME],
+			    sizeof(node.node_name));
+
+	list->fn(&node, list->data);
+
+	return NL_OK;
+}
+
+/**
+ * igt_drm_ras_nl_list_nodes - Call @fn for each registered DRM RAS node
+ * @ctx: initialized DRM RAS netlink context
+ * @fn: called once per node
+ * @data: passed to @fn
+ *
+ * Returns: 0 on success, negative errno otherwise.
+ */
+int igt_drm_ras_nl_list_nodes(struct igt_drm_ras_nl_context *ctx,
+			      igt_drm_ras_node_fn fn, void *data)
+{
+	struct node_list list = { fn, data };
+
+	return request(ctx, DRM_RAS_CMD_LIST_NODES, NLM_F_DUMP, 0, 0, node_cb, &list);
+}
+
+struct error_counter_list {
+	igt_drm_ras_error_counter_fn fn;
+	void *data;
+};
+
+static int error_counter_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *tb[DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX + 1];
+	struct error_counter_list *list = arg;
+	struct igt_drm_ras_error_counter counter = {};
+
+	if (genlmsg_parse(nlmsg_hdr(msg), 0, tb, DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX, NULL) ||
+	    !tb[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] ||
+	    !tb[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE])
+		return NL_SKIP;
+
+	counter.id = nla_get_u32(tb[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
+	counter.value = nla_get_u32(tb[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE]);
+	if (tb[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME])
+		nla_strlcpy(counter.name, tb[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME],
+			    sizeof(counter.name));
+
+	list->fn(&counter, list->data);
+
+	return NL_OK;
+}
+
+/**
+ * igt_drm_ras_nl_list_error_counters - Call @fn for each error counter of a node
+ * @ctx: initialized DRM RAS netlink context
+ * @node_id: error-counter node ID
+ * @fn: called once per error counter
+ * @data: passed to @fn
+ *
+ * Returns: 0 on success, negative errno otherwise.
+ */
+int igt_drm_ras_nl_list_error_counters(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+				       igt_drm_ras_error_counter_fn fn, void *data)
+{
+	struct error_counter_list list = { fn, data };
+
+	return request(ctx, DRM_RAS_CMD_GET_ERROR_COUNTER, NLM_F_DUMP,
+		       DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID, node_id, error_counter_cb, &list);
+}
diff --git a/lib/igt_drm_ras_nl.h b/lib/igt_drm_ras_nl.h
index 46d31599d..4980904f8 100644
--- a/lib/igt_drm_ras_nl.h
+++ b/lib/igt_drm_ras_nl.h
@@ -62,8 +62,43 @@ struct igt_drm_ras_nl_context {
 
 	/** @subscribed_grp_id: Multicast group ID currently subscribed to, or -1 if none */
 	int subscribed_grp_id;
+
+	/** @dump_interrupted: Set when the kernel flagged the last dump as interrupted */
+	bool dump_interrupted;
+};
+
+#define IGT_DRM_RAS_NAME_LEN 64
+
+/**
+ * struct igt_drm_ras_node - DRM RAS node
+ */
+struct igt_drm_ras_node {
+	/** @id: Node ID */
+	uint32_t id;
+	/** @type: Node type (enum drm_ras_node_type) */
+	uint32_t type;
+	/** @device_name: Name of the device the node belongs to */
+	char device_name[IGT_DRM_RAS_NAME_LEN];
+	/** @node_name: Name of the node */
+	char node_name[IGT_DRM_RAS_NAME_LEN];
 };
 
+/**
+ * struct igt_drm_ras_error_counter - DRM RAS error counter
+ */
+struct igt_drm_ras_error_counter {
+	/** @id: Error ID */
+	uint32_t id;
+	/** @name: Error name */
+	char name[IGT_DRM_RAS_NAME_LEN];
+	/** @value: Counter value */
+	uint32_t value;
+};
+
+typedef void (*igt_drm_ras_node_fn)(const struct igt_drm_ras_node *node, void *data);
+typedef void (*igt_drm_ras_error_counter_fn)(const struct igt_drm_ras_error_counter *counter,
+					     void *data);
+
 void igt_drm_ras_nl_cleanup(struct igt_drm_ras_nl_context *ctx);
 int igt_drm_ras_nl_init(struct igt_drm_ras_nl_context *ctx);
 int igt_drm_ras_nl_get_error_counter(struct igt_drm_ras_nl_context *ctx);
@@ -72,5 +107,9 @@ int igt_drm_ras_nl_set_error_threshold(struct igt_drm_ras_nl_context *ctx);
 int igt_drm_ras_nl_subscribe_error_report(struct igt_drm_ras_nl_context *ctx,
 					  const char *notify_group_name);
 int igt_drm_ras_nl_wait_for_error_report_event(struct igt_drm_ras_nl_context *ctx, int timeout_ms);
+int igt_drm_ras_nl_list_nodes(struct igt_drm_ras_nl_context *ctx,
+			      igt_drm_ras_node_fn fn, void *data);
+int igt_drm_ras_nl_list_error_counters(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+				       igt_drm_ras_error_counter_fn fn, void *data);
 
 #endif /* IGT_DRM_RAS_NL_H */
-- 
2.56.0

