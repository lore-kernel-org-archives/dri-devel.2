Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11F606A327
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8B7112854;
	Fri, 27 Nov 2026 08:29:44 +0000 (UTC)
X-Greylist: delayed 586 seconds by postgrey-1.36 at gabe;
 Fri, 27 Nov 2026 06:05:03 UTC
Received: from smtp92-17.hiworks.co.kr (smtp92-17.hiworks.co.kr
 [139.150.92.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CCC1120F5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:05:03 +0000 (UTC)
Received: from hi-smtp-node4 (unknown [172.18.0.2])
 by smtp92-17.hiworks.co.kr (Postfix) with ESMTPS id 4jbN1H2J0zzkTq1W
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:55:15 +0900 (KST)
Received: from hi-smtp-node1 (unknown [192.168.71.167])
 by hi-smtp-node4 (Postfix) with ESMTP id 4jbN1H27VvzQLCTT
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:55:15 +0900 (KST)
Received: from split.smtp.hiworks.com
 (amphora-3294b420-308a-4b9e-8a1d-bf25580dae1f.openstack.gabia.io)
 by hi-smtp-node1 with ESMTP id nbfgmrij4omgew2z;
 Fri, 27 Nov 2026 14:55:15 +0900 (KST)
Received: from hiworks-k8s (EHLO mail-api-v2-prod-84c9f6b4d9-7nd99)
 (10.251.248.0) by 0 (smtp-channel-split) with SMTP;
 Fri, 27 Nov 2026 14:55:15 +0900
Date: Fri, 27 Nov 2026 14:55:14 +0900 (KST)
From: Young-Jun Hong <nirvanah@nirvanahyj.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexey Sheplyakov <asheplyakov@basealt.ru>,
 "Vadim V. Vlasov" <vadim.vlasov@elpitech.ru>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <gab1288179556.0.1795758914837@nirvanahyj.com>
Subject: RE: Re: [PATCH 3/4] drm/panfrost: only put powered shader cores in
 the job affinity
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
 boundary="----=_Part_50612_808278289.1795758914837"
X-Priority: 3
X-Authinfo: HIWORKS WEB authenticated <nirvanah@nirvanahyj.com|223.38.56.95>
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
Reply-To: Young-Jun Hong <young.j.hong@kaist.ac.kr>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

------=_Part_50612_808278289.1795758914837
Content-Type: multipart/related; 
	boundary="----=_Part_50613_399170304.1795758914837"

------=_Part_50613_399170304.1795758914837
Content-Type: multipart/alternative; 
	boundary="----=_Part_50614_1900592143.1795758914842"

------=_Part_50614_1900592143.1795758914842
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGkgU3RldmUsClRoYW5rcyBmb3IgbG9va2luZyBpbnRvIHRoaXMuClJlZ2FyZGluZyAoYSksIEkg
cGVyc29uYWxseSByYW4gdGhvc2UgZXhwZXJpbWVudHMgb24gdGhlIGhhcmR3YXJlIGFuZCByZXZp
ZXdlZCB0aGUgcmVzdWx0cy4KVGhlIHB1cnBvc2Ugb2YgdGhlIHRlc3Rpbmcgd2FzIHRvIGRldGVy
bWluZSB3aGV0aGVyIHRoZSB0d28gbm9uLWNvaGVyZW50IGNvcmUgZ3JvdXBzIG9mIHRoZSBNYWxp
LVQ2MjggY2FuIGJlIHVzZWQgdG9nZXRoZXIgc2FmZWx5LCB3aGV0aGVyIGRvaW5nIHNvIHByb3Zp
ZGVzIGEgbWVhbmluZ2Z1bCBwZXJmb3JtYW5jZSBiZW5lZml0LCBhbmQgd2hldGhlciBhbnkgY29y
cmVjdG5lc3MgaXNzdWVzIGNhbiBiZSBjb250cm9sbGVkIHRocm91Z2ggdXNlcnNwYWNlIHNjaGVk
dWxpbmcgcnVsZXMuClRoZSBhY2N1cmFjeSBhbmQgcGVyZm9ybWFuY2UgY29tcGFyaXNvbiB3YXMg
cGVyZm9ybWVkIG9uIHRoZSBzYW1lIGJvYXJkIGFuZCBzb2Z0d2FyZSBzdGFjayBhdCA2MDAgTUh6
IHVuZGVyIHRocmVlIGNvbmRpdGlvbnM6CsKgIENvbnRyb2wgQSA6IGpvYiBwbGFjZW1lbnQgZXF1
aXZhbGVudCB0byB1cHN0cmVhbSBiZWhhdmlvdXIsIHVzaW5nIG9ubHkgY29yZSBncm91cCAwICg0
IGNvcmVzKcKgIENvbnRyb2wgQiA6IGJvdGggY29yZSBncm91cHMgZW5hYmxlZCwgd2l0aCB0aGUg
YWRkaXRpb25hbCB1c2Vyc3BhY2UgZmlsdGVyaW5nIHJ1bGVzIGRpc2FibGVkwqAgRmlsdGVyZWTC
oCA6IGJvdGggY29yZSBncm91cHMgZW5hYmxlZCwgd2l0aCB1c2Vyc3BhY2UgZmlsdGVyaW5nIG9m
IGtub3duLXJpc2sgam9icwpDb250cm9sIEEgYWNoaWV2ZWQgMjUuNjggR0ZMT1BTLiBFbmFibGlu
ZyBib3RoIGNvcmUgZ3JvdXBzIGluY3JlYXNlZCB0aHJvdWdocHV0IHRvIDM3LjY3IEdGTE9QUyBp
biBDb250cm9sIEIgYW5kIDM3LjU2IEdGTE9QUyBpbiBGaWx0ZXJlZCwgY29ycmVzcG9uZGluZyB0
byByb3VnaGx5IGEgMS40NngtMS40N3ggc3BlZWR1cC4KSG93ZXZlciwgQ29udHJvbCBCIGFsc28g
cmVwcm9kdWNlZCBhbGwgdGhyZWUgcHJldmlvdXNseSBvYnNlcnZlZCBoYXphcmQgY2xhc3NlczoK
wqAgLSBSZWFkLW1vZGlmeS13cml0ZSB0ZXN0IChEOCk6IGxvc3QgdXBkYXRlcyBpbiAxMC8xMCBy
dW5zSGkgU3RldmUsClRoYW5rcyBmb3IgbG9va2luZyBpbnRvIHRoaXMuClJlZ2FyZGluZyAoYSks
IEkgcGVyc29uYWxseSByYW4gdGhvc2UgZXhwZXJpbWVudHMgb24gdGhlIGhhcmR3YXJlIGFuZCBy
ZXZpZXdlZCB0aGUgcmVzdWx0cy4KVGhlIHB1cnBvc2Ugb2YgdGhlIHRlc3Rpbmcgd2FzIHRvIGRl
dGVybWluZSB3aGV0aGVyIHRoZSB0d28gbm9uLWNvaGVyZW50IGNvcmUgZ3JvdXBzIG9mIHRoZSBN
YWxpLVQ2MjggY2FuIGJlIHVzZWQgdG9nZXRoZXIgc2FmZWx5LCB3aGV0aGVyIGRvaW5nIHNvIHBy
b3ZpZGVzIGEgbWVhbmluZ2Z1bCBwZXJmb3JtYW5jZSBiZW5lZml0LCBhbmQgd2hldGhlciBhbnkg
Y29ycmVjdG5lc3MgaXNzdWVzIGNhbiBiZSBjb250cm9sbGVkIHRocm91Z2ggdXNlcnNwYWNlIHNj
aGVkdWxpbmcgcnVsZXMuClRoZSBhY2N1cmFjeSBhbmQgcGVyZm9ybWFuY2UgY29tcGFyaXNvbiB3
YXMgcGVyZm9ybWVkIG9uIHRoZSBzYW1lIGJvYXJkIGFuZCBzb2Z0d2FyZSBzdGFjayBhdCA2MDAg
TUh6IHVuZGVyIHRocmVlIGNvbmRpdGlvbnM6CsKgIENvbnRyb2wgQSA6IGpvYiBwbGFjZW1lbnQg
ZXF1aXZhbGVudCB0byB1cHN0cmVhbSBiZWhhdmlvdXIsIHVzaW5nIG9ubHkgY29yZSBncm91cCAw
ICg0IGNvcmVzKcKgIENvbnRyb2wgQiA6IGJvdGggY29yZSBncm91cHMgZW5hYmxlZCwgd2l0aCB0
aGUgYWRkaXRpb25hbCB1c2Vyc3BhY2UgZmlsdGVyaW5nIHJ1bGVzIGRpc2FibGVkwqAgRmlsdGVy
ZWTCoCA6IGJvdGggY29yZSBncm91cHMgZW5hYmxlZCwgd2l0aCB1c2Vyc3BhY2UgZmlsdGVyaW5n
IG9mIGtub3duLXJpc2sgam9icwpDb250cm9sIEEgYWNoaWV2ZWQgMjUuNjggR0ZMT1BTLiBFbmFi
bGluZyBib3RoIGNvcmUgZ3JvdXBzIGluY3JlYXNlZCB0aHJvdWdocHV0IHRvIDM3LjY3IEdGTE9Q
UyBpbiBDb250cm9sIEIgYW5kIDM3LjU2IEdGTE9QUyBpbiBGaWx0ZXJlZCwgY29ycmVzcG9uZGlu
ZyB0byByb3VnaGx5IGEgMS40NngtMS40N3ggc3BlZWR1cC4KSG93ZXZlciwgQ29udHJvbCBCIGFs
c28gcmVwcm9kdWNlZCBhbGwgdGhyZWUgcHJldmlvdXNseSBvYnNlcnZlZCBoYXphcmQgY2xhc3Nl
czoKwqAgLSBSZWFkLW1vZGlmeS13cml0ZSB0ZXN0IChEOCk6IGxvc3QgdXBkYXRlcyBpbiAxMC8x
MCBydW5zwqAgLSBUTFMgc3BpbGwtcmVsYXRlZCB0ZXN0OiBpbmNvcnJlY3QgcmVzdWx0cyBpbiAy
LzUgcnVucwoKCkhpIFN0ZXZlLApUaGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGlzLgpSZWdhcmRp
bmcgKGEpLCBJIHBlcnNvbmFsbHkgcmFuIHRob3NlIGV4cGVyaW1lbnRzIG9uIHRoZSBoYXJkd2Fy
ZSBhbmQgcmV2aWV3ZWQgdGhlIHJlc3VsdHMuClRoZSBwdXJwb3NlIG9mIHRoZSB0ZXN0aW5nIHdh
cyB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUgdHdvIG5vbi1jb2hlcmVudCBjb3JlIGdyb3VwcyBv
ZiB0aGUgTWFsaS1UNjI4IGNhbiBiZSB1c2VkIHRvZ2V0aGVyIHNhZmVseSwgd2hldGhlciBkb2lu
ZyBzbyBwcm92aWRlcyBhIG1lYW5pbmdmdWwgcGVyZm9ybWFuY2UgYmVuZWZpdCwgYW5kIHdoZXRo
ZXIgYW55IGNvcnJlY3RuZXNzIGlzc3VlcyBjYW4gYmUgY29udHJvbGxlZCB0aHJvdWdoIHVzZXJz
cGFjZSBzY2hlZHVsaW5nIHJ1bGVzLgpUaGUgYWNjdXJhY3kgYW5kIHBlcmZvcm1hbmNlIGNvbXBh
cmlzb24gd2FzIHBlcmZvcm1lZCBvbiB0aGUgc2FtZSBib2FyZCBhbmQgc29mdHdhcmUgc3RhY2sg
YXQgNjAwIE1IeiB1bmRlciB0aHJlZSBjb25kaXRpb25zOkhpIFN0ZXZlLApUaGFua3MgZm9yIGxv
b2tpbmcgaW50byB0aGlzLgpSZWdhcmRpbmcgKGEpLCBJIHBlcnNvbmFsbHkgcmFuIHRob3NlIGV4
cGVyaW1lbnRzIG9uIHRoZSBoYXJkd2FyZSBhbmQgcmV2aWV3ZWQgdGhlIHJlc3VsdHMuClRoZSBw
dXJwb3NlIG9mIHRoZSB0ZXN0aW5nIHdhcyB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUgdHdvIG5v
bi1jb2hlcmVudCBjb3JlIGdyb3VwcyBvZiB0aGUgTWFsaS1UNjI4IGNhbiBiZSB1c2VkIHRvZ2V0
aGVyIHNhZmVseSwgd2hldGhlciBkb2luZyBzbyBwcm92aWRlcyBhIG1lYW5pbmdmdWwgcGVyZm9y
bWFuY2UgYmVuZWZpdCwgYW5kIHdoZXRoZXIgYW55IGNvcnJlY3RuZXNzIGlzc3VlcyBjYW4gYmUg
Y29udHJvbGxlZCB0aHJvdWdoIHVzZXJzcGFjZSBzY2hlZHVsaW5nIHJ1bGVzLgpUaGUgYWNjdXJh
Y3kgYW5kIHBlcmZvcm1hbmNlIGNvbXBhcmlzb24gd2FzIHBlcmZvcm1lZCBvbiB0aGUgc2FtZSBi
b2FyZCBhbmQgc29mdHdhcmUgc3RhY2sgYXQgNjAwIE1IeiB1bmRlciB0aHJlZSBjb25kaXRpb25z
OgrCoCBDb250cm9sIEEgOiBqb2IgcGxhY2VtZW50IGVxdWl2YWxlbnQgdG8gdXBzdHJlYW0gYmVo
YXZpb3VyLCB1c2luZyBvbmx5IGNvcmUgZ3JvdXAgMCAoNCBjb3JlcynCoCBDb250cm9sIEIgOiBi
b3RoIGNvcmUgZ3JvdXBzIGVuYWJsZWQsIHdpdGggdGhlIGFkZGl0aW9uYWwgdXNlcnNwYWNlIGZp
bHRlcmluZyBydWxlcyBkaXNhYmxlZMKgIEZpbHRlcmVkwqAgOiBib3RoIGNvcmUgZ3JvdXBzIGVu
YWJsZWQsIHdpdGggdXNlcnNwYWNlIGZpbHRlcmluZyBvZiBrbm93bi1yaXNrIGpvYnMKQ29udHJv
bCBBIGFjaGlldmVkIDI1LjY4IEdGTE9QUy4gRW5hYmxpbmcgYm90aCBjb3JlIGdyb3VwcyBpbmNy
ZWFzZWQgdGhyb3VnaHB1dCB0byAzNy42NyBHRkxPUFMgaW4gQ29udHJvbCBCIGFuZCAzNy41NiBH
RkxPUFMgaW4gRmlsdGVyZWQsIGNvcnJlc3BvbmRpbmcgdG8gcm91Z2hseSBhIDEuNDZ4LTEuNDd4
IHNwZWVkdXAuCkhvd2V2ZXIsIENvbnRyb2wgQiBhbHNvIHJlcHJvZHVjZWQgYWxsIHRocmVlIHBy
ZXZpb3VzbHkgb2JzZXJ2ZWQgaGF6YXJkIGNsYXNzZXM6CsKgIC0gUmVhZC1tb2RpZnktd3JpdGUg
dGVzdCAoRDgpOiBsb3N0IHVwZGF0ZXMgaW4gMTAvMTAgcnVuc8KgIC0gVExTIHNwaWxsLXJlbGF0
ZWQgdGVzdDogaW5jb3JyZWN0IHJlc3VsdHMgaW4gMi81IHJ1bnPCoCAtIENMQmxhc3QgRlA2NCBy
ZXBsYXkgKFAxNik6IDU2LzU2IHJlcGxheWVkIHByb2dyYW0gZXhlY3V0aW9ucyBwcm9kdWNlZCBt
aXNtYXRjaGVzwqAgLSBHUFUgZmF1bHRzOiAxCldpdGggdXNlcnNwYWNlIGZpbHRlcmluZyBlbmFi
bGVkLCBwZXJmb3JtYW5jZSByZW1haW5lZCBlc3NlbnRpYWxseSB1bmNoYW5nZWQgd2hpbGUgYWxs
IG9ic2VydmVkIGNvcnJlY3RuZXNzIGZhaWx1cmVzIGFuZCBHUFUgZmF1bHRzIHdlcmUgcmVkdWNl
ZCB0byB6ZXJvLgpSZWdhcmRpbmcgKGQpLCBteSBtZWFzdXJlbWVudHMgYXJlIGNvbnNpc3RlbnQg
d2l0aCB5b3VyIGV4cGxhbmF0aW9uIHRoYXQgdGhlIGhhcmR3YXJlIGVmZmVjdGl2ZWx5IEFORHMg
dGhlIGpvYiBhZmZpbml0eSB3aXRoIHRoZSBwb3dlcmVkIHNoYWRlciBjb3Jlcy4KV2l0aCBjb3Jl
IGdyb3VwIDEgcG93ZXJlZCBvZmYsIHdyaXRpbmcgYW4gYWZmaW5pdHkgb2YgMHgzZiBzdGlsbCBy
ZXN1bHRlZCBpbiBvbmx5IDB4MGYgb2Ygc2hhZGVyIGNvcmVzIGJlaW5nIGFjdGl2ZSBkdXJpbmcg
ZXhlY3V0aW9uLiBQZXJmb3JtYW5jZSBhbmQgb3V0cHV0IGNvcnJlY3RuZXNzIHdlcmUgYWxzbyB1
bmNoYW5nZWQuIEJhc2VkIG9uIHRoYXQgcmVzdWx0LCBJIGFncmVlIHRoYXQgcGF0Y2ggMy80IGRv
ZXMgbm90IHByb3ZpZGUgYSBwcmFjdGljYWwgYmVuZWZpdCBieSBpdHNlbGYsIGFuZCBJIGFtIHdp
dGhkcmF3aW5nIDMvNC4KUmVnYXJkaW5nIChiKSwgSSBhbHNvIGFncmVlIHRoYXQgNC80IGVmZmVj
dGl2ZWx5IHN1YnN1bWVzIHRoZSBpbnRlbnQgb2YgMy80LiBJZiBhZmZpbml0eSBpcyBleHBsaWNp
dGx5IHByb2dyYW1tZWQgb24gYSBwZXItam9iIGJhc2lzLCB0aGVyZSBpcyBubyBuZWVkIGZvciB0
aGUgY2hhbmdlIHByb3Bvc2VkIGluIDMvNC4KRm9yIChjKSwgdGhlIG1lYXN1cmVtZW50cyBzdWdn
ZXN0IHRoYXQgc3VwcG9ydCBmb3IgdGhlIHNlY29uZCBjb3JlIGdyb3VwIGNhbiBwcm92aWRlIGEg
c3Vic3RhbnRpYWwgcGVyZm9ybWFuY2UgYmVuZWZpdCwgYnV0IGEga2VybmVsLXNpZGUgb3B0LWlu
IGFsb25lIGlzIG5vdCBzdWZmaWNpZW50LgpXaXRob3V0IGFkZGl0aW9uYWwgc2NoZWR1bGluZyBy
dWxlcywgRDgsIFRMUyBhbmQgUDE2IHdvcmtsb2FkcyBjYW4gcHJvZHVjZSBpbmNvcnJlY3QgcmVz
dWx0cyBhbmQgR1BVIGZhdWx0cy4gV2l0aCBmaWx0ZXJpbmcgZW5hYmxlZCwgdGhlIHNhbWUgcGVy
Zm9ybWFuY2UgZ2FpbiBpcyByZXRhaW5lZCB3aGlsZSB0aGUgb2JzZXJ2ZWQgZmFpbHVyZXMgZGlz
YXBwZWFyLgpUaGVyZWZvcmUsIG15IGN1cnJlbnQgdmlldyBpcyB0aGF0IGEga2VybmVsLXNpZGUg
b3B0LWluIGlzIG9ubHkgbWVhbmluZ2Z1bCB3aGVuIGFjY29tcGFuaWVkIGJ5IGNvcnJlc3BvbmRp
bmcgdXNlcnNwYWNlIHJ1bGVzIHRoYXQgZGVjaWRlIHdoaWNoIHdvcmtsb2FkcyBtYXkgYmUgZGlz
cGF0Y2hlZCB0byBib3RoIGNvcmUgZ3JvdXBzLiBUaGUgdXNlcnNwYWNlIHNpZGUgaXMgb3V0c2lk
ZSB0aGUgc2NvcGUgb2YgdGhpcyBrZXJuZWwgc2VyaWVzLCBzbyBJIGFtIG5vdCBwcm9wb3Npbmcg
c3VjaCBhIHBvbGljeSBhcyBwYXJ0IG9mIHRoZXNlIHBhdGNoZXMuCklmIHRoZXJlIGlzIGludGVy
ZXN0IGluIHN1cHBvcnRpbmcgdGhpcyBjb25maWd1cmF0aW9uIGZ1cnRoZXIsIEkgd291bGQgYmUg
aGFwcHkgdG8gc2hhcmUgdGhlIG1lYXN1cmVtZW50IG1ldGhvZG9sb2d5IGFuZCBvYnNlcnZhdGlv
bnMgYmVoaW5kIHRoZXNlIHJlc3VsdHMuCkJlc3QgUmVnYXJkcyxZSgotLS0tLS0tLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0tLS0tLS0tU3ViamVjdCA6IFJlOiBbUEFUQ0ggMy80XSBkcm0vcGFu
ZnJvc3Q6IG9ubHkgcHV0IHBvd2VyZWQgc2hhZGVyIGNvcmVzIGluIHRoZSBqb2IgYWZmaW5pdHlE
YXRlIDogMjAyNi0xMS0yNCAwMDozODowMEZyb20gOiBTdGV2ZW4gUHJpY2UgPHN0ZXZlbi5wcmlj
ZUBhcm0uY29tPlRvIDogWW91bmctSnVuIEhvbmcgPG5pcnZhbmFoQG5pcnZhbmFoeWouY29tPkNj
IDogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4sUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz4sQWRyacOhbiBMYXJ1bWJlIDxhZHJpYW4ubGFydW1iZUBj
b2xsYWJvcmEuY29tPixNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXgu
aW50ZWwuY29tPixNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5vcmc+LFRob21hcyBaaW1t
ZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPixEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21haWwu
Y29tPixTaW1vbmEgVmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+LEFsZXhleSBTaGVwbHlha292IDxh
c2hlcGx5YWtvdkBiYXNlYWx0LnJ1PiwiVmFkaW0gVi4gVmxhc292IiA8dmFkaW0udmxhc292QGVs
cGl0ZWNoLnJ1PixkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnLGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmdPbsKgMDYvMTEvMjAyNsKgMDU6NDEswqBZb3VuZy1KdW7CoEhvbmfCoHdy
b3RlOgo+wqBPbsKgR1BVc8Kgd2l0aMKgbW9yZcKgdGhhbsKgb25lwqBMMsKgKGNvcmXCoGdyb3Vw
KSzCoHBhbmZyb3N0wqBwb3dlcnPCoG9ubHnCoHRoZQo+wqBmaXJzdMKgY29yZcKgZ3JvdXDCoChw
YW5mcm9zdF9nZXRfY29yZV9tYXNrKCkpLMKgYnV0wqB0aGXCoGpvYsKgYWZmaW5pdHnCoGlzCj7C
oHdyaXR0ZW7CoGZyb23CoHNoYWRlcl9wcmVzZW50LMKgaS5lLsKgaXTCoGFsc2/CoG5hbWVzwqB0
aGXCoGNvcmVzwqBvZsKgdGhlwqBzZWNvbmQsCj7CoHVucG93ZXJlZMKgZ3JvdXDCoChNYWxpLVQ2
MjjCoE1QNsKgb27CoEV4eW5vc8KgNTQyMjrCoGwyX3ByZXNlbnTCoDB4MTEswqA0KzIKPsKgY29y
ZXMswqBhZmZpbml0ecKgMHgzZsKgd2hpbGXCoG9ubHnCoDB4MGbCoGlzwqBwb3dlcmVkKS4KPsKg
Cj7CoFdyaXRlwqB0aGXCoGFmZmluaXR5wqBmcm9twqB0aGXCoHNhbWXCoG1hc2vCoHRoYXTCoHdh
c8KgcG93ZXJlZCzCoHNvwqBhwqBqb2LCoG5ldmVyCj7CoG5hbWVzwqBjb3Jlc8KgdGhhdMKgYXJl
wqBvZmYuCj7CoAo+wqBUZXN0ZWTCoG9uwqBTYW1zdW5nwqBBUlRJS8KgMTDCoChFeHlub3PCoDU0
MjIpLMKgTWFsaS1UNjI4wqBNUDYuCj7CoAo+wqBUaGXCoGFuYWx5c2lzLMKgdGhlwqBjb2RlwqBh
bmTCoHRoaXPCoGNoYW5nZWxvZ8Kgd2VyZcKgcHJvZHVjZWTCoHdpdGjCoENsYXVkZQo+wqBDb2Rl
wqAoQW50aHJvcGljKSzCoGHCoGNvZGluZ8KgYXNzaXN0YW50Lgo+wqAKPsKgRml4ZXM6wqA2ZTU1
ZDI3MzcwOGLCoCgiZHJtL3BhbmZyb3N0OsKgaW5pdGlhbMKgZHVhbMKgY29yZcKgZ3JvdXDCoEdQ
VXPCoHN1cHBvcnQiKQo+wqBTaWduZWQtb2ZmLWJ5OsKgWW91bmctSnVuwqBIb25nwqA8bmlydmFu
YWhAbmlydmFuYWh5ai5jb20+CgpTb8KgdGhpc8KgcGF0Y2jCoG1pZ2h0wqBiZcKgYcKgdmFsaWTC
oGZpeC7CoEJ1dDoKCmEpwqBJdCdzwqBBScKgZ2VuZXJhdGVkwqBhbmTCoEknbcKgbm90wqBzdXJl
wqB3aGV0aGVywqBhbnnCoGh1bWFuwqB0aG91Z2h0wqBoYXPCoGdvbmUKaW50b8KgaXQuCgpiKcKg
VGhlwqBuZXh0wqBwYXRjaMKgaW7CoHRoZcKgc2VyaWVzwqBiYXNpY2FsbHnCoHVuZG9lc8KgdGhl
wqBjaGFuZ2UuCgpUaGXCoFQ2MjjCoGlzwqBhbsKgYXdrd2FyZMKgYmVhc3TCoGJlY2F1c2XCoGl0
wqBoYXPCoHRoZXNlwqB0d2/CoChub24tY29oZXJlbnQpCmNvcmXCoGdyb3Vwcy7CoFNvwqBmYXLC
oHRoZXJlwqBoYXNuJ3TCoGJlZW7CoG11Y2jCoGFwcGV0aXRlwqBmb3LCoHRyeWluZ8KgdG8Kc3Vw
cG9ydMKgaXTCoHdlbGzCoGJlY2F1c2XCoGl0J3PCoHByZXR0ecKgcmFyZcKgYW5kwqBBRkFJS8Kg
aXQnc8KgdGhlwqBvbmx5wqBHUFUKd2hpY2jCoGhhc8KgdGhpc8Kgc2V0dXAuCgpNecKgb3duwqB1
bmRlcnN0YW5kaW5nwqBpc8KgdGhhdMKgdGhpc8KgcGF0Y2jCoGlzwqBhbHNvwqBpcnJlbGV2YW50
wqBpbsKgdGhhdMKgdGhlCkdQVcKgaGFyZHdhcmXCoHdpbGzCoGVmZmVjdGl2ZWx5wqBBTkTCoHRo
ZcKgYWZmaW5pdHnCoHdpdGjCoHRoZcKgcG93ZXJlZMKgb24Kc2hhZGVycy7CoEhlbmNlwqBJJ2TC
oHdhbnTCoHRvwqBzZWXCoGFuwqBhY3R1YWzCoHVzZXLCoHJlcG9ydMKgKG5vdMKgYW7CoEFJLXJl
cG9ydCkKdGhhdMKgdGhpc8KgImZpeCLCoGFjdHVhbGx5wqBoZWxwcy7CoFNhZGx5wqBJwqBkb24n
dMKgaGF2ZcKgaGFyZHdhcmXCoHRvwqB0ZXN0wqB0aGlzLgoKVGhhbmtzLApTdGV2ZQoKPsKgLS0t
Cj7CoMKgZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2dwdS5jwqB8wqA2wqArKysr
KysKPsKgwqBkcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZ3B1LmjCoHzCoDHCoCsK
PsKgwqBkcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3Rfam9iLmPCoHzCoDLCoCstCj7C
oMKgM8KgZmlsZXPCoGNoYW5nZWQswqA4wqBpbnNlcnRpb25zKCspLMKgMcKgZGVsZXRpb24oLSkK
PsKgCj7CoGRpZmbCoC0tZ2l0wqBhL2RyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9n
cHUuY8KgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZ3B1LmMKPsKgaW5kZXjC
oDYwODFiMjc4MjllMS4uNDIwZDIyNDI3NmE1wqAxMDA2NDQKPsKgLS0twqBhL2RyaXZlcnMvZ3B1
L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9ncHUuYwo+wqArKyvCoGIvZHJpdmVycy9ncHUvZHJtL3Bh
bmZyb3N0L3BhbmZyb3N0X2dwdS5jCj7CoEBAwqAtNDUyLDbCoCs0NTIsMTLCoEBAwqBzdGF0aWPC
oHU2NMKgcGFuZnJvc3RfZ2V0X2NvcmVfbWFzayhzdHJ1Y3TCoHBhbmZyb3N0X2RldmljZcKgKnBm
ZGV2KQo+wqDCoAlyZXR1cm7CoGNvcmVfbWFzazsKPsKgwqB9Cj7CoMKgCj7CoCsvKsKgY29yZXPC
oHRoYXTCoHBhbmZyb3N0X2dwdV9wb3dlcl9vbigpwqBwb3dlcnPCoCovCj7CoCt1NjTCoHBhbmZy
b3N0X3Bvd2VyZWRfY29yZV9tYXNrKHN0cnVjdMKgcGFuZnJvc3RfZGV2aWNlwqAqcGZkZXYpCj7C
oCt7Cj7CoCsJcmV0dXJuwqBwZmRldi0+ZmVhdHVyZXMuc2hhZGVyX3ByZXNlbnTCoCbCoHBhbmZy
b3N0X2dldF9jb3JlX21hc2socGZkZXYpOwo+wqArfQo+wqArCj7CoMKgdm9pZMKgcGFuZnJvc3Rf
Z3B1X3Bvd2VyX29uKHN0cnVjdMKgcGFuZnJvc3RfZGV2aWNlwqAqcGZkZXYpCj7CoMKgewo+wqDC
oAlpbnTCoHJldDsKPsKgZGlmZsKgLS1naXTCoGEvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3Bh
bmZyb3N0X2dwdS5owqBiL2RyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9ncHUuaAo+
wqBpbmRleMKgYjRmZWYxMTIxMWQ1Li43OGE2MjcwYjdmY2LCoDEwMDY0NAo+wqAtLS3CoGEvZHJp
dmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2dwdS5oCj7CoCsrK8KgYi9kcml2ZXJzL2dw
dS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZ3B1LmgKPsKgQEDCoC0xMyw2wqArMTMsN8KgQEDCoHZv
aWTCoHBhbmZyb3N0X2dwdV9maW5pKHN0cnVjdMKgcGFuZnJvc3RfZGV2aWNlwqAqcGZkZXYpOwo+
wqDCoHUzMsKgcGFuZnJvc3RfZ3B1X2dldF9sYXRlc3RfZmx1c2hfaWQoc3RydWN0wqBwYW5mcm9z
dF9kZXZpY2XCoCpwZmRldik7Cj7CoMKgCj7CoMKgaW50wqBwYW5mcm9zdF9ncHVfc29mdF9yZXNl
dChzdHJ1Y3TCoHBhbmZyb3N0X2RldmljZcKgKnBmZGV2KTsKPsKgK3U2NMKgcGFuZnJvc3RfcG93
ZXJlZF9jb3JlX21hc2soc3RydWN0wqBwYW5mcm9zdF9kZXZpY2XCoCpwZmRldik7Cj7CoMKgdm9p
ZMKgcGFuZnJvc3RfZ3B1X3Bvd2VyX29uKHN0cnVjdMKgcGFuZnJvc3RfZGV2aWNlwqAqcGZkZXYp
Owo+wqDCoHZvaWTCoHBhbmZyb3N0X2dwdV9wb3dlcl9vZmYoc3RydWN0wqBwYW5mcm9zdF9kZXZp
Y2XCoCpwZmRldik7Cj7CoMKgdm9pZMKgcGFuZnJvc3RfZ3B1X3N1c3BlbmRfaXJxKHN0cnVjdMKg
cGFuZnJvc3RfZGV2aWNlwqAqcGZkZXYpOwo+wqBkaWZmwqAtLWdpdMKgYS9kcml2ZXJzL2dwdS9k
cm0vcGFuZnJvc3QvcGFuZnJvc3Rfam9iLmPCoGIvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3Bh
bmZyb3N0X2pvYi5jCj7CoGluZGV4wqA0ZGRmNGI3MjJkZGYuLjMzZGE4NjU4N2RiN8KgMTAwNjQ0
Cj7CoC0tLcKgYS9kcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3Rfam9iLmMKPsKgKysr
wqBiL2RyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9qb2IuYwo+wqBAQMKgLTE0Myw3
wqArMTQzLDfCoEBAwqBzdGF0aWPCoHZvaWTCoHBhbmZyb3N0X2pvYl93cml0ZV9hZmZpbml0eShz
dHJ1Y3TCoHBhbmZyb3N0X2RldmljZcKgKnBmZGV2LAo+wqDCoAnCoCrCoEV2ZW50dWFsbHnCoHdl
wqBtYXnCoG5lZWTCoHRvwqBzdXBwb3J0wqB0aWxlcsKgb25secKgam9ic8KgYW5kwqBoL3fCoHdp
dGgKPsKgwqAJwqAqwqBtdWx0aXBsZcKgKDIpwqBjb2hlcmVudMKgY29yZcKgZ3JvdXBzCj7CoMKg
CcKgKi8KPsKgLQlhZmZpbml0ecKgPcKgcGZkZXYtPmZlYXR1cmVzLnNoYWRlcl9wcmVzZW50Owo+
wqArCWFmZmluaXR5wqA9wqBwYW5mcm9zdF9wb3dlcmVkX2NvcmVfbWFzayhwZmRldik7Cj7CoMKg
Cj7CoMKgCWpvYl93cml0ZShwZmRldizCoEpTX0FGRklOSVRZX05FWFRfTE8oanMpLMKgbG93ZXJf
MzJfYml0cyhhZmZpbml0eSkpOwo+wqDCoAlqb2Jfd3JpdGUocGZkZXYswqBKU19BRkZJTklUWV9O
RVhUX0hJKGpzKSzCoHVwcGVyXzMyX2JpdHMoYWZmaW5pdHkpKTsKCg==
------=_Part_50614_1900592143.1795758914842
Content-Type: text/html;charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Hi Steve,</div><div><br></div><div>Thanks for looking into this.</div>=
<div><br></div><div>Regarding (a), I personally ran those experiments on th=
e hardware and reviewed the results.</div><div><br></div><div>The purpose o=
f the testing was to determine whether the two non-coherent core groups of =
the Mali-T628 can be used together safely, whether doing so provides a mean=
ingful performance benefit, and whether any correctness issues can be contr=
olled through userspace scheduling rules.</div><div><br></div><div>The accu=
racy and performance comparison was performed on the same board and softwar=
e stack at 600 MHz under three conditions:</div><div><br></div><div>&nbsp; =
Control A : job placement equivalent to upstream behaviour, using only core=
 group 0 (4 cores)</div><div>&nbsp; Control B : both core groups enabled, w=
ith the additional userspace filtering rules disabled</div><div>&nbsp; Filt=
ered&nbsp; : both core groups enabled, with userspace filtering of known-ri=
sk jobs</div><div><br></div><div>Control A achieved 25.68 GFLOPS. Enabling =
both core groups increased throughput to 37.67 GFLOPS in Control B and 37.5=
6 GFLOPS in Filtered, corresponding to roughly a 1.46x-1.47x speedup.</div>=
<div><br></div><div>However, Control B also reproduced all three previously=
 observed hazard classes:</div><div><br></div><div>&nbsp; - Read-modify-wri=
te test (D8): lost updates in 10/10 runs</div><div><div>Hi Steve,</div><div=
><br></div><div>Thanks for looking into this.</div><div><br></div><div>Rega=
rding (a), I personally ran those experiments on the hardware and reviewed =
the results.</div><div><br></div><div>The purpose of the testing was to det=
ermine whether the two non-coherent core groups of the Mali-T628 can be use=
d together safely, whether doing so provides a meaningful performance benef=
it, and whether any correctness issues can be controlled through userspace =
scheduling rules.</div><div><br></div><div>The accuracy and performance com=
parison was performed on the same board and software stack at 600 MHz under=
 three conditions:</div><div><br></div><div>&nbsp; Control A : job placemen=
t equivalent to upstream behaviour, using only core group 0 (4 cores)</div>=
<div>&nbsp; Control B : both core groups enabled, with the additional users=
pace filtering rules disabled</div><div>&nbsp; Filtered&nbsp; : both core g=
roups enabled, with userspace filtering of known-risk jobs</div><div><br></=
div><div>Control A achieved 25.68 GFLOPS. Enabling both core groups increas=
ed throughput to 37.67 GFLOPS in Control B and 37.56 GFLOPS in Filtered, co=
rresponding to roughly a 1.46x-1.47x speedup.</div><div><br></div><div>Howe=
ver, Control B also reproduced all three previously observed hazard classes=
:</div><div><br></div><div>&nbsp; - Read-modify-write test (D8): lost updat=
es in 10/10 runs</div><div>&nbsp; - TLS spill-related test: incorrect resul=
ts in 2/5 runs</div><div><br></div></div><div><br></div><div><br></div><div=
><div>Hi Steve,</div><div><br></div><div>Thanks for looking into this.</div=
><div><br></div><div>Regarding (a), I personally ran those experiments on t=
he hardware and reviewed the results.</div><div><br></div><div>The purpose =
of the testing was to determine whether the two non-coherent core groups of=
 the Mali-T628 can be used together safely, whether doing so provides a mea=
ningful performance benefit, and whether any correctness issues can be cont=
rolled through userspace scheduling rules.</div><div><br></div><div>The acc=
uracy and performance comparison was performed on the same board and softwa=
re stack at 600 MHz under three conditions:</div><div>Hi Steve,</div><div><=
br></div><div>Thanks for looking into this.</div><div><br></div><div>Regard=
ing (a), I personally ran those experiments on the hardware and reviewed th=
e results.</div><div><br></div><div>The purpose of the testing was to deter=
mine whether the two non-coherent core groups of the Mali-T628 can be used =
together safely, whether doing so provides a meaningful performance benefit=
, and whether any correctness issues can be controlled through userspace sc=
heduling rules.</div><div><br></div><div>The accuracy and performance compa=
rison was performed on the same board and software stack at 600 MHz under t=
hree conditions:</div><div><br></div><div>&nbsp; Control A : job placement =
equivalent to upstream behaviour, using only core group 0 (4 cores)</div><d=
iv>&nbsp; Control B : both core groups enabled, with the additional userspa=
ce filtering rules disabled</div><div>&nbsp; Filtered&nbsp; : both core gro=
ups enabled, with userspace filtering of known-risk jobs</div><div><br></di=
v><div>Control A achieved 25.68 GFLOPS. Enabling both core groups increased=
 throughput to 37.67 GFLOPS in Control B and 37.56 GFLOPS in Filtered, corr=
esponding to roughly a 1.46x-1.47x speedup.</div><div><br></div><div>Howeve=
r, Control B also reproduced all three previously observed hazard classes:<=
/div><div><br></div><div>&nbsp; - Read-modify-write test (D8): lost updates=
 in 10/10 runs</div><div>&nbsp; - TLS spill-related test: incorrect results=
 in 2/5 runs</div><div>&nbsp; - CLBlast FP64 replay (P16): 56/56 replayed p=
rogram executions produced mismatches</div><div>&nbsp; - GPU faults: 1</div=
><div><br></div><div>With userspace filtering enabled, performance remained=
 essentially unchanged while all observed correctness failures and GPU faul=
ts were reduced to zero.</div><div><br></div><div>Regarding (d), my measure=
ments are consistent with your explanation that the hardware effectively AN=
Ds the job affinity with the powered shader cores.</div><div><br></div><div=
>With core group 1 powered off, writing an affinity of 0x3f still resulted =
in only 0x0f of shader cores being active during execution. Performance and=
 output correctness were also unchanged. Based on that result, I agree that=
 patch 3/4 does not provide a practical benefit by itself, and I am withdra=
wing 3/4.</div><div><br></div><div>Regarding (b), I also agree that 4/4 eff=
ectively subsumes the intent of 3/4. If affinity is explicitly programmed o=
n a per-job basis, there is no need for the change proposed in 3/4.</div><d=
iv><br></div><div>For (c), the measurements suggest that support for the se=
cond core group can provide a substantial performance benefit, but a kernel=
-side opt-in alone is not sufficient.</div><div><br></div><div>Without addi=
tional scheduling rules, D8, TLS and P16 workloads can produce incorrect re=
sults and GPU faults. With filtering enabled, the same performance gain is =
retained while the observed failures disappear.</div><div><br></div><div>Th=
erefore, my current view is that a kernel-side opt-in is only meaningful wh=
en accompanied by corresponding userspace rules that decide which workloads=
 may be dispatched to both core groups. The userspace side is outside the s=
cope of this kernel series, so I am not proposing such a policy as part of =
these patches.</div><div><br></div><div>If there is interest in supporting =
this configuration further, I would be happy to share the measurement metho=
dology and observations behind these results.</div><div><br></div><div>Best=
 Regards,</div><div>YJ</div></div><div><br></div><blockquote style=3D"PADDI=
NG: 0 0 0 5px; MARGIN: 0 0 0 5px; BORDER-LEFT: #000000 2px solid;"><div id=
=3D"GOV_SAAS_DEXT_FORWARD_CONTENTS"><p style=3D"font-size:10pt;line-height:=
1.6em">------------Original Message------------</p><p style=3D"font-size:10=
pt;line-height:1.6em"><b>Subject :</b> Re: [PATCH 3/4] drm/panfrost: only p=
ut powered shader cores in the job affinity</p><p style=3D"font-size:10pt;l=
ine-height:1.6em"><b>Date :</b> 2026-11-24 00:38:00</p><p style=3D"font-siz=
e:10pt;line-height:1.6em"><b>From :</b> Steven Price &lt;steven.price@arm.c=
om&gt;</p><p style=3D"font-size:10pt;line-height:1.6em"><b>To :</b> Young-J=
un Hong &lt;nirvanah@nirvanahyj.com&gt;</p><p style=3D"font-size:10pt;line-=
height:1.6em"><b>Cc :</b> Boris Brezillon &lt;boris.brezillon@collabora.com=
&gt;,Rob Herring &lt;robh@kernel.org&gt;,Adri=C3=A1n Larumbe &lt;adrian.lar=
umbe@collabora.com&gt;,Maarten Lankhorst &lt;maarten.lankhorst@linux.intel.=
com&gt;,Maxime Ripard &lt;mripard@kernel.org&gt;,Thomas Zimmermann &lt;tzim=
mermann@suse.de&gt;,David Airlie &lt;airlied@gmail.com&gt;,Simona Vetter &l=
t;simona@ffwll.ch&gt;,Alexey Sheplyakov &lt;asheplyakov@basealt.ru&gt;,"Vad=
im V. Vlasov" &lt;vadim.vlasov@elpitech.ru&gt;,dri-devel@lists.freedesktop.=
org,linux-kernel@vger.kernel.org</p>On&nbsp;06/11/2026&nbsp;05:41,&nbsp;You=
ng-Jun&nbsp;Hong&nbsp;wrote:<br>&gt;&nbsp;On&nbsp;GPUs&nbsp;with&nbsp;more&=
nbsp;than&nbsp;one&nbsp;L2&nbsp;(core&nbsp;group),&nbsp;panfrost&nbsp;power=
s&nbsp;only&nbsp;the<br>&gt;&nbsp;first&nbsp;core&nbsp;group&nbsp;(panfrost=
_get_core_mask()),&nbsp;but&nbsp;the&nbsp;job&nbsp;affinity&nbsp;is<br>&gt;=
&nbsp;written&nbsp;from&nbsp;shader_present,&nbsp;i.e.&nbsp;it&nbsp;also&nb=
sp;names&nbsp;the&nbsp;cores&nbsp;of&nbsp;the&nbsp;second,<br>&gt;&nbsp;unp=
owered&nbsp;group&nbsp;(Mali-T628&nbsp;MP6&nbsp;on&nbsp;Exynos&nbsp;5422:&n=
bsp;l2_present&nbsp;0x11,&nbsp;4+2<br>&gt;&nbsp;cores,&nbsp;affinity&nbsp;0=
x3f&nbsp;while&nbsp;only&nbsp;0x0f&nbsp;is&nbsp;powered).<br>&gt;&nbsp;<br>=
&gt;&nbsp;Write&nbsp;the&nbsp;affinity&nbsp;from&nbsp;the&nbsp;same&nbsp;ma=
sk&nbsp;that&nbsp;was&nbsp;powered,&nbsp;so&nbsp;a&nbsp;job&nbsp;never<br>&=
gt;&nbsp;names&nbsp;cores&nbsp;that&nbsp;are&nbsp;off.<br>&gt;&nbsp;<br>&gt=
;&nbsp;Tested&nbsp;on&nbsp;Samsung&nbsp;ARTIK&nbsp;10&nbsp;(Exynos&nbsp;542=
2),&nbsp;Mali-T628&nbsp;MP6.<br>&gt;&nbsp;<br>&gt;&nbsp;The&nbsp;analysis,&=
nbsp;the&nbsp;code&nbsp;and&nbsp;this&nbsp;changelog&nbsp;were&nbsp;produce=
d&nbsp;with&nbsp;Claude<br>&gt;&nbsp;Code&nbsp;(Anthropic),&nbsp;a&nbsp;cod=
ing&nbsp;assistant.<br>&gt;&nbsp;<br>&gt;&nbsp;Fixes:&nbsp;6e55d273708b&nbs=
p;("drm/panfrost:&nbsp;initial&nbsp;dual&nbsp;core&nbsp;group&nbsp;GPUs&nbs=
p;support")<br>&gt;&nbsp;Signed-off-by:&nbsp;Young-Jun&nbsp;Hong&nbsp;&lt;n=
irvanah@nirvanahyj.com&gt;<br><br>So&nbsp;this&nbsp;patch&nbsp;might&nbsp;b=
e&nbsp;a&nbsp;valid&nbsp;fix.&nbsp;But:<br><br>a)&nbsp;It's&nbsp;AI&nbsp;ge=
nerated&nbsp;and&nbsp;I'm&nbsp;not&nbsp;sure&nbsp;whether&nbsp;any&nbsp;hum=
an&nbsp;thought&nbsp;has&nbsp;gone<br>into&nbsp;it.<br><br>b)&nbsp;The&nbsp=
;next&nbsp;patch&nbsp;in&nbsp;the&nbsp;series&nbsp;basically&nbsp;undoes&nb=
sp;the&nbsp;change.<br><br>The&nbsp;T628&nbsp;is&nbsp;an&nbsp;awkward&nbsp;=
beast&nbsp;because&nbsp;it&nbsp;has&nbsp;these&nbsp;two&nbsp;(non-coherent)=
<br>core&nbsp;groups.&nbsp;So&nbsp;far&nbsp;there&nbsp;hasn't&nbsp;been&nbs=
p;much&nbsp;appetite&nbsp;for&nbsp;trying&nbsp;to<br>support&nbsp;it&nbsp;w=
ell&nbsp;because&nbsp;it's&nbsp;pretty&nbsp;rare&nbsp;and&nbsp;AFAIK&nbsp;i=
t's&nbsp;the&nbsp;only&nbsp;GPU<br>which&nbsp;has&nbsp;this&nbsp;setup.<br>=
<br>My&nbsp;own&nbsp;understanding&nbsp;is&nbsp;that&nbsp;this&nbsp;patch&n=
bsp;is&nbsp;also&nbsp;irrelevant&nbsp;in&nbsp;that&nbsp;the<br>GPU&nbsp;har=
dware&nbsp;will&nbsp;effectively&nbsp;AND&nbsp;the&nbsp;affinity&nbsp;with&=
nbsp;the&nbsp;powered&nbsp;on<br>shaders.&nbsp;Hence&nbsp;I'd&nbsp;want&nbs=
p;to&nbsp;see&nbsp;an&nbsp;actual&nbsp;user&nbsp;report&nbsp;(not&nbsp;an&n=
bsp;AI-report)<br>that&nbsp;this&nbsp;"fix"&nbsp;actually&nbsp;helps.&nbsp;=
Sadly&nbsp;I&nbsp;don't&nbsp;have&nbsp;hardware&nbsp;to&nbsp;test&nbsp;this=
.<br><br>Thanks,<br>Steve<br><br>&gt;&nbsp;---<br>&gt;&nbsp;&nbsp;drivers/g=
pu/drm/panfrost/panfrost_gpu.c&nbsp;|&nbsp;6&nbsp;++++++<br>&gt;&nbsp;&nbsp=
;drivers/gpu/drm/panfrost/panfrost_gpu.h&nbsp;|&nbsp;1&nbsp;+<br>&gt;&nbsp;=
&nbsp;drivers/gpu/drm/panfrost/panfrost_job.c&nbsp;|&nbsp;2&nbsp;+-<br>&gt;=
&nbsp;&nbsp;3&nbsp;files&nbsp;changed,&nbsp;8&nbsp;insertions(+),&nbsp;1&nb=
sp;deletion(-)<br>&gt;&nbsp;<br>&gt;&nbsp;diff&nbsp;--git&nbsp;a/drivers/gp=
u/drm/panfrost/panfrost_gpu.c&nbsp;b/drivers/gpu/drm/panfrost/panfrost_gpu.=
c<br>&gt;&nbsp;index&nbsp;6081b27829e1..420d224276a5&nbsp;100644<br>&gt;&nb=
sp;---&nbsp;a/drivers/gpu/drm/panfrost/panfrost_gpu.c<br>&gt;&nbsp;+++&nbsp=
;b/drivers/gpu/drm/panfrost/panfrost_gpu.c<br>&gt;&nbsp;@@&nbsp;-452,6&nbsp=
;+452,12&nbsp;@@&nbsp;static&nbsp;u64&nbsp;panfrost_get_core_mask(struct&nb=
sp;panfrost_device&nbsp;*pfdev)<br>&gt;&nbsp;&nbsp;=09return&nbsp;core_mask=
;<br>&gt;&nbsp;&nbsp;}<br>&gt;&nbsp;&nbsp;<br>&gt;&nbsp;+/*&nbsp;cores&nbsp=
;that&nbsp;panfrost_gpu_power_on()&nbsp;powers&nbsp;*/<br>&gt;&nbsp;+u64&nb=
sp;panfrost_powered_core_mask(struct&nbsp;panfrost_device&nbsp;*pfdev)<br>&=
gt;&nbsp;+{<br>&gt;&nbsp;+=09return&nbsp;pfdev-&gt;features.shader_present&=
nbsp;&amp;&nbsp;panfrost_get_core_mask(pfdev);<br>&gt;&nbsp;+}<br>&gt;&nbsp=
;+<br>&gt;&nbsp;&nbsp;void&nbsp;panfrost_gpu_power_on(struct&nbsp;panfrost_=
device&nbsp;*pfdev)<br>&gt;&nbsp;&nbsp;{<br>&gt;&nbsp;&nbsp;=09int&nbsp;ret=
;<br>&gt;&nbsp;diff&nbsp;--git&nbsp;a/drivers/gpu/drm/panfrost/panfrost_gpu=
.h&nbsp;b/drivers/gpu/drm/panfrost/panfrost_gpu.h<br>&gt;&nbsp;index&nbsp;b=
4fef11211d5..78a6270b7fcb&nbsp;100644<br>&gt;&nbsp;---&nbsp;a/drivers/gpu/d=
rm/panfrost/panfrost_gpu.h<br>&gt;&nbsp;+++&nbsp;b/drivers/gpu/drm/panfrost=
/panfrost_gpu.h<br>&gt;&nbsp;@@&nbsp;-13,6&nbsp;+13,7&nbsp;@@&nbsp;void&nbs=
p;panfrost_gpu_fini(struct&nbsp;panfrost_device&nbsp;*pfdev);<br>&gt;&nbsp;=
&nbsp;u32&nbsp;panfrost_gpu_get_latest_flush_id(struct&nbsp;panfrost_device=
&nbsp;*pfdev);<br>&gt;&nbsp;&nbsp;<br>&gt;&nbsp;&nbsp;int&nbsp;panfrost_gpu=
_soft_reset(struct&nbsp;panfrost_device&nbsp;*pfdev);<br>&gt;&nbsp;+u64&nbs=
p;panfrost_powered_core_mask(struct&nbsp;panfrost_device&nbsp;*pfdev);<br>&=
gt;&nbsp;&nbsp;void&nbsp;panfrost_gpu_power_on(struct&nbsp;panfrost_device&=
nbsp;*pfdev);<br>&gt;&nbsp;&nbsp;void&nbsp;panfrost_gpu_power_off(struct&nb=
sp;panfrost_device&nbsp;*pfdev);<br>&gt;&nbsp;&nbsp;void&nbsp;panfrost_gpu_=
suspend_irq(struct&nbsp;panfrost_device&nbsp;*pfdev);<br>&gt;&nbsp;diff&nbs=
p;--git&nbsp;a/drivers/gpu/drm/panfrost/panfrost_job.c&nbsp;b/drivers/gpu/d=
rm/panfrost/panfrost_job.c<br>&gt;&nbsp;index&nbsp;4ddf4b722ddf..33da86587d=
b7&nbsp;100644<br>&gt;&nbsp;---&nbsp;a/drivers/gpu/drm/panfrost/panfrost_jo=
b.c<br>&gt;&nbsp;+++&nbsp;b/drivers/gpu/drm/panfrost/panfrost_job.c<br>&gt;=
&nbsp;@@&nbsp;-143,7&nbsp;+143,7&nbsp;@@&nbsp;static&nbsp;void&nbsp;panfros=
t_job_write_affinity(struct&nbsp;panfrost_device&nbsp;*pfdev,<br>&gt;&nbsp;=
&nbsp;=09&nbsp;*&nbsp;Eventually&nbsp;we&nbsp;may&nbsp;need&nbsp;to&nbsp;su=
pport&nbsp;tiler&nbsp;only&nbsp;jobs&nbsp;and&nbsp;h/w&nbsp;with<br>&gt;&nb=
sp;&nbsp;=09&nbsp;*&nbsp;multiple&nbsp;(2)&nbsp;coherent&nbsp;core&nbsp;gro=
ups<br>&gt;&nbsp;&nbsp;=09&nbsp;*/<br>&gt;&nbsp;-=09affinity&nbsp;=3D&nbsp;=
pfdev-&gt;features.shader_present;<br>&gt;&nbsp;+=09affinity&nbsp;=3D&nbsp;=
panfrost_powered_core_mask(pfdev);<br>&gt;&nbsp;&nbsp;<br>&gt;&nbsp;&nbsp;=
=09job_write(pfdev,&nbsp;JS_AFFINITY_NEXT_LO(js),&nbsp;lower_32_bits(affini=
ty));<br>&gt;&nbsp;&nbsp;=09job_write(pfdev,&nbsp;JS_AFFINITY_NEXT_HI(js),&=
nbsp;upper_32_bits(affinity));<br><br></div></blockquote>
<table style=3D"display:none"><tbody><tr><td><img gabiamail src=3D"https://=
mail-api.office.hiworks.com/v2/office/15829/receipt-confirm/20261127025514_=
667424019_nirvanahyj.com_nirvanah/email/dri-devel@lists.freedesktop.org" width=3D=
"1" height=3D"1" style=3D"display:none;" border=3D"0" loading=3D"eager"></t=
d></tr></tbody></table>

------=_Part_50614_1900592143.1795758914842--

------=_Part_50613_399170304.1795758914837--

------=_Part_50612_808278289.1795758914837--
